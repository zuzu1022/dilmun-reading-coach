using DilmunReadingCoach.Core.Entities;
using DilmunReadingCoach.Infrastructure.Data;
using DilmunReadingCoach.Infrastructure.Identity;
using DilmunReadingCoach.Web.Models;
using DilmunReadingCoach.Web.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace DilmunReadingCoach.Web.Controllers;

public class AccountController : Controller
{
    private readonly UserManager<ApplicationUser> _userManager;
    private readonly SignInManager<ApplicationUser> _signInManager;
    private readonly IAuditService _auditService;
    private readonly ApplicationDbContext _context;

    public AccountController(
        UserManager<ApplicationUser> userManager,
        SignInManager<ApplicationUser> signInManager,
        IAuditService auditService,
        ApplicationDbContext context)
    {
        _userManager = userManager;
        _signInManager = signInManager;
        _auditService = auditService;
        _context = context;
    }

    [HttpGet]
    [AllowAnonymous]
    public IActionResult Login(string? returnUrl = null)
    {
        ViewData["ReturnUrl"] = returnUrl;
        return View();
    }

    [HttpPost]
    [AllowAnonymous]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Login(LoginViewModel model, string? returnUrl = null)
    {
        if (!ModelState.IsValid)
        {
            return View(model);
        }

        var user = await _userManager.FindByNameAsync(model.Username);
        if (user == null)
        {
            ModelState.AddModelError("", "The username you entered does not exist. Please check your username and try again.");
            return View(model);
        }

        if (!user.IsActive)
        {
            ModelState.AddModelError("", "Your account has been deactivated. Please contact your coordinator for assistance.");
            return View(model);
        }

        var result = await _signInManager.PasswordSignInAsync(model.Username, model.Password, model.RememberMe, lockoutOnFailure: true);
        
        if (result.Succeeded)
        {
            await _auditService.LogActionAsync(
                user.Id,
                "Login",
                null,
                null,
                $"User {user.UserName} logged in",
                HttpContext.Connection.RemoteIpAddress?.ToString());

            return RedirectToLocal(returnUrl);
        }

        if (result.IsLockedOut)
        {
            ModelState.AddModelError("", "Your account has been temporarily locked due to multiple failed login attempts. Please contact your coordinator or try again later.");
            return View(model);
        }

        if (result.IsNotAllowed)
        {
            ModelState.AddModelError("", "You are not allowed to sign in. Please contact your coordinator for assistance.");
            return View(model);
        }

        // Password is incorrect
        ModelState.AddModelError("", "The password you entered is incorrect. Please check your password and try again.");
        return View(model);
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Logout()
    {
        var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
        if (Guid.TryParse(userId, out var userIdGuid))
        {
            await _auditService.LogActionAsync(
                userIdGuid,
                "Logout",
                null,
                null,
                $"User logged out",
                HttpContext.Connection.RemoteIpAddress?.ToString());
        }

        await _signInManager.SignOutAsync();
        return RedirectToAction(nameof(Login));
    }

    [HttpPost]
    [Authorize]
    public IActionResult KeepAlive()
    {
        // Extend session by touching it
        HttpContext.Session.SetString("LastActivity", DateTime.UtcNow.ToString());
        return Ok();
    }

    [HttpPost]
    [AllowAnonymous]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> RequestPasswordReset(string username)
    {
        if (string.IsNullOrWhiteSpace(username))
        {
            TempData["ResetRequestError"] = "Please enter a username.";
            return RedirectToAction(nameof(Login));
        }

        var user = await _userManager.FindByNameAsync(username);
        if (user == null)
        {
            // Don't reveal if user exists or not for security
            TempData["ResetRequestSuccess"] = "If the username exists, your password reset request has been sent to the coordinator for approval.";
            return RedirectToAction(nameof(Login));
        }

        if (!user.IsActive)
        {
            TempData["ResetRequestError"] = "Your account has been deactivated. Please contact your coordinator for assistance.";
            return RedirectToAction(nameof(Login));
        }

        // Check if there's already a pending request for this user
        var existingRequest = await _context.PasswordResetRequests
            .FirstOrDefaultAsync(r => r.UserId == user.Id && r.Status == "Pending");

        if (existingRequest != null)
        {
            TempData["ResetRequestSuccess"] = "Your password reset request has already been submitted and is pending coordinator approval.";
            return RedirectToAction(nameof(Login));
        }

        // Create new password reset request
        var resetRequest = new PasswordResetRequest
        {
            UserId = user.Id,
            Status = "Pending",
            CreatedAtUtc = DateTime.UtcNow,
            UpdatedAtUtc = DateTime.UtcNow
        };

        _context.PasswordResetRequests.Add(resetRequest);
        await _context.SaveChangesAsync();

        TempData["ResetRequestSuccess"] = "Your password reset request has been sent to the coordinator for approval. You will be notified once it's approved.";
        return RedirectToAction(nameof(Login));
    }

    private IActionResult RedirectToLocal(string? returnUrl)
    {
        if (Url.IsLocalUrl(returnUrl))
            return Redirect(returnUrl);

        var user = _userManager.GetUserAsync(User).Result;
        if (user?.Role == "Coordinator")
            return RedirectToAction("Coordinator", "Dashboard");
        
        return RedirectToAction("Teacher", "Dashboard");
    }
}

