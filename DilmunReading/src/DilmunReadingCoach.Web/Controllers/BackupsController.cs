using DilmunReadingCoach.Web.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace DilmunReadingCoach.Web.Controllers;

[Authorize(Roles = "Coordinator")]
public class BackupsController : Controller
{
    private readonly IBackupService _backupService;
    private readonly IAuditService _auditService;

    public BackupsController(IBackupService backupService, IAuditService auditService)
    {
        _backupService = backupService;
        _auditService = auditService;
    }

    public async Task<IActionResult> Index()
    {
        var backups = await _backupService.GetBackupHistoryAsync();
        return View(backups);
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> CreateBackup()
    {
        var userId = Guid.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);
        var backup = await _backupService.CreateBackupAsync(userId);
        
        await _auditService.LogActionAsync(
            userId,
            "Backup",
            "Backup",
            backup.Id,
            "Manual backup created",
            HttpContext.Connection.RemoteIpAddress?.ToString());

        return RedirectToAction(nameof(Index));
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Restore(Guid id)
    {
        var success = await _backupService.RestoreBackupAsync(id);
        
        if (success)
        {
            var userId = Guid.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);
            await _auditService.LogActionAsync(
                userId,
                "Restore",
                "Backup",
                id,
                "Database restored from backup",
                HttpContext.Connection.RemoteIpAddress?.ToString());

            TempData["Success"] = "Database restored successfully";
        }
        else
        {
            TempData["Error"] = "Restore failed";
        }

        return RedirectToAction(nameof(Index));
    }
}

