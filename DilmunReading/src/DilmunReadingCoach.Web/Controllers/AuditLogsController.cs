using DilmunReadingCoach.Core.Entities;
using DilmunReadingCoach.Infrastructure.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace DilmunReadingCoach.Web.Controllers;

[Authorize(Roles = "Coordinator")]
public class AuditLogsController : Controller
{
    private readonly ApplicationDbContext _context;

    public AuditLogsController(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<IActionResult> Index(string? actionType, string? entity, DateTime? startDate, DateTime? endDate, int page = 1, int pageSize = 50)
    {
        var query = _context.AuditLogs.AsQueryable();

        if (!string.IsNullOrEmpty(actionType))
            query = query.Where(a => a.ActionType == actionType);

        if (!string.IsNullOrEmpty(entity))
            query = query.Where(a => a.Entity == entity);

        if (startDate.HasValue)
            query = query.Where(a => a.CreatedAtUtc >= startDate.Value);

        if (endDate.HasValue)
            query = query.Where(a => a.CreatedAtUtc <= endDate.Value.AddDays(1));

        var totalCount = await query.CountAsync();
        var logs = await query
            .OrderByDescending(a => a.CreatedAtUtc)
            .Skip((page - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync();

        // Load related users in one query for display
        var userIds = logs.Select(l => l.UserId).Distinct().ToList();
        var users = await _context.Users
            .Where(u => userIds.Contains(u.Id))
            .ToListAsync();

        ViewBag.TotalCount = totalCount;
        ViewBag.Page = page;
        ViewBag.PageSize = pageSize;
        ViewBag.TotalPages = (int)Math.Ceiling(totalCount / (double)pageSize);
        ViewBag.ActionTypes = await _context.AuditLogs.Select(a => a.ActionType).Distinct().ToListAsync();
        ViewBag.Entities = await _context.AuditLogs.Where(a => a.Entity != null).Select(a => a.Entity!).Distinct().ToListAsync();
        ViewBag.Users = users.ToDictionary(u => u.Id, u => u.UserName);

        return View(logs);
    }

    public async Task<IActionResult> Details(long id)
    {
        var log = await _context.AuditLogs
            .FirstOrDefaultAsync(a => a.Id == id);

        if (log == null) return NotFound();

        var user = await _context.Users.FirstOrDefaultAsync(u => u.Id == log.UserId);
        ViewBag.UserName = user?.UserName ?? "Unknown";

        return View(log);
    }
}

