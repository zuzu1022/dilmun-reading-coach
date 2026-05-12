using DilmunReadingCoach.Core.Entities;
using DilmunReadingCoach.Infrastructure.Data;
using DilmunReadingCoach.Infrastructure.Identity;
using DilmunReadingCoach.Web.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace DilmunReadingCoach.Web.Controllers;

[Authorize(Roles = "Coordinator")]
public class PasswordResetsController : Controller
{
    private readonly ApplicationDbContext _context;
    private readonly UserManager<ApplicationUser> _userManager;
    private readonly IAuditService _auditService;

    public PasswordResetsController(
        ApplicationDbContext context,
        UserManager<ApplicationUser> userManager,
        IAuditService auditService)
    {
        _context = context;
        _userManager = userManager;
        _auditService = auditService;
    }

    public async Task<IActionResult> Index(string? status)
    {
        var query = _context.PasswordResetRequests.AsQueryable();

        if (!string.IsNullOrEmpty(status))
            query = query.Where(p => p.Status == status);

        var requests = await query
            .OrderByDescending(p => p.CreatedAtUtc)
            .ToListAsync();

        // Load users for display
        var userIds = requests.Select(r => r.UserId).Concat(
            requests.Where(r => r.ApprovedBy.HasValue).Select(r => r.ApprovedBy!.Value)
        ).Distinct().ToList();
        
        var users = await _context.Users.Where(u => userIds.Contains(u.Id)).ToListAsync();
        ViewBag.Users = users.ToDictionary(u => u.Id, u => u);
        ViewBag.Status = status;
        
        return View(requests);
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Approve(Guid id, string newPassword, string confirmPassword)
    {
        var request = await _context.PasswordResetRequests
            .FirstOrDefaultAsync(p => p.Id == id);

        if (request == null || request.Status != "Pending")
            return NotFound();

        var user = await _userManager.FindByIdAsync(request.UserId.ToString());
        if (user == null) return NotFound();

        // Validate password
        if (string.IsNullOrWhiteSpace(newPassword))
        {
            TempData["Error"] = "Password is required.";
            return RedirectToAction(nameof(Index));
        }

        if (newPassword != confirmPassword)
        {
            TempData["Error"] = "Passwords do not match.";
            return RedirectToAction(nameof(Index));
        }

        if (newPassword.Length < 6)
        {
            TempData["Error"] = "Password must be at least 6 characters long.";
            return RedirectToAction(nameof(Index));
        }

        // Reset password with the provided password
        var token = await _userManager.GeneratePasswordResetTokenAsync(user);
        var result = await _userManager.ResetPasswordAsync(user, token, newPassword);

        if (result.Succeeded)
        {
            request.Status = "Approved";
            request.ApprovedBy = Guid.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);
            request.ApprovedAtUtc = DateTime.UtcNow;
            request.UpdatedAtUtc = DateTime.UtcNow;
            await _context.SaveChangesAsync();

            await _auditService.LogActionAsync(
                request.ApprovedBy.Value,
                "Update",
                "PasswordResetRequest",
                id,
                $"Approved password reset for user {user.UserName} - password set by coordinator",
                HttpContext.Connection.RemoteIpAddress?.ToString());

            TempData["Success"] = $"Password reset approved successfully. The password has been set for user {user.UserName}.";
        }
        else
        {
            TempData["Error"] = string.Join(", ", result.Errors.Select(e => e.Description));
        }

        return RedirectToAction(nameof(Index));
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Reject(Guid id)
    {
        var request = await _context.PasswordResetRequests.FindAsync(id);
        if (request == null || request.Status != "Pending")
            return NotFound();

        request.Status = "Rejected";
        request.UpdatedAtUtc = DateTime.UtcNow;
        await _context.SaveChangesAsync();

        var userId = Guid.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);
        await _auditService.LogActionAsync(
            userId,
            "Update",
            "PasswordResetRequest",
            id,
            "Rejected password reset request",
            HttpContext.Connection.RemoteIpAddress?.ToString());

        TempData["Success"] = "Password reset request rejected";
        return RedirectToAction(nameof(Index));
    }
}
