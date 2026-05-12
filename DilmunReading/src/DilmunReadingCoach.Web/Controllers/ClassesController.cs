using DilmunReadingCoach.Core.Entities;
using DilmunReadingCoach.Infrastructure.Data;
using DilmunReadingCoach.Web.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace DilmunReadingCoach.Web.Controllers;

[Authorize(Roles = "Coordinator")]
public class ClassesController : Controller
{
    private readonly ApplicationDbContext _context;
    private readonly IAuditService _auditService;

    public ClassesController(ApplicationDbContext context, IAuditService auditService)
    {
        _context = context;
        _auditService = auditService;
    }

    public async Task<IActionResult> Index()
    {
        var classes = await _context.Classrooms.OrderBy(c => c.Name).ToListAsync();
        return View(classes);
    }

    public IActionResult Create()
    {
        return View();
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Create(Classroom classroom)
    {
        if (ModelState.IsValid)
        {
            classroom.Id = Guid.NewGuid();
            classroom.CreatedAtUtc = DateTime.UtcNow;
            classroom.Status = "Active";
            _context.Classrooms.Add(classroom);
            await _context.SaveChangesAsync();
            await LogAudit("Create", classroom.Id, "Classroom");
            return RedirectToAction(nameof(Index));
        }

        return View(classroom);
    }

    public async Task<IActionResult> Edit(Guid id)
    {
        var classroom = await _context.Classrooms.FindAsync(id);
        if (classroom == null) return NotFound();

        return View(classroom);
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Edit(Classroom classroom)
    {
        if (ModelState.IsValid)
        {
            classroom.UpdatedAtUtc = DateTime.UtcNow;
            _context.Classrooms.Update(classroom);
            await _context.SaveChangesAsync();
            await LogAudit("Update", classroom.Id, "Classroom");
            return RedirectToAction(nameof(Index));
        }

        return View(classroom);
    }

    public async Task<IActionResult> Delete(Guid id)
    {
        var classroom = await _context.Classrooms.FindAsync(id);
        if (classroom == null) return NotFound();

        return View(classroom);
    }

    [HttpPost, ActionName("Delete")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> DeleteConfirmed(Guid id)
    {
        var classroom = await _context.Classrooms.FindAsync(id);
        if (classroom != null)
        {
            classroom.Status = "Inactive";
            classroom.UpdatedAtUtc = DateTime.UtcNow;
            await _context.SaveChangesAsync();
            await LogAudit("Delete", id, "Classroom");
        }

        return RedirectToAction(nameof(Index));
    }

    private async Task LogAudit(string action, Guid entityId, string entity)
    {
        var userId = Guid.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);
        await _auditService.LogActionAsync(
            userId,
            action,
            entity,
            entityId,
            $"{action} {entity}",
            HttpContext.Connection.RemoteIpAddress?.ToString());
    }
}

