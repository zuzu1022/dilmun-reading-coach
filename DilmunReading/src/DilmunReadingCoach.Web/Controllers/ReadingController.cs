using DilmunReadingCoach.Core.Entities;
using DilmunReadingCoach.Infrastructure.Data;
using DilmunReadingCoach.Web.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace DilmunReadingCoach.Web.Controllers;

[Authorize]
public class ReadingController : Controller
{
    private readonly IReadingService _readingService;
    private readonly IStudentService _studentService;
    private readonly IAuditService _auditService;
    private readonly ApplicationDbContext _context;
    private readonly ITeacherService _teacherService;

    public ReadingController(
        IReadingService readingService,
        IStudentService studentService,
        IAuditService auditService,
        ApplicationDbContext context,
        ITeacherService teacherService)
    {
        _readingService = readingService;
        _studentService = studentService;
        _auditService = auditService;
        _context = context;
        _teacherService = teacherService;
    }

    [Authorize(Roles = "Coordinator,Teacher")]
    public async Task<IActionResult> Index(Guid? studentId, Guid? classroomId, string? weekStart)
    {
        var userRole = User.FindFirstValue("Role") ?? User.FindFirstValue(ClaimTypes.Role);
        var userId = Guid.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);

        DateOnly? weekStartDate = null;
        if (!string.IsNullOrEmpty(weekStart) && DateOnly.TryParse(weekStart, out var parsed))
            weekStartDate = parsed;

        List<ReadingProgress> records;

        if (userRole == "Coordinator")
        {
            records = await _readingService.GetReadingProgressAsync(studentId, classroomId, weekStartDate);
        }
        else
        {
            var teacherClassroomIds = await _teacherService.GetTeacherClassroomIdsAsync(userId);
            records = await _readingService.GetReadingProgressAsync(studentId, null, weekStartDate);
            records = records.Where(r => teacherClassroomIds.Contains(r.Student?.ClassroomId ?? Guid.Empty)).ToList();
        }

        ViewBag.Students = await _context.Students.Where(s => s.Status == "Active").ToListAsync();
        ViewBag.Classrooms = await _context.Classrooms.Where(c => c.Status == "Active").ToListAsync();
        ViewBag.Books = await _context.Books.Where(b => b.Status == "Available").ToListAsync();

        return View(records);
    }

    [Authorize(Roles = "Coordinator,Teacher")]
    public async Task<IActionResult> Create()
    {
        var userRole = User.FindFirstValue("Role") ?? User.FindFirstValue(ClaimTypes.Role);
        var userId = Guid.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);

        ViewBag.Students = await GetAvailableStudentsAsync(userRole, userId);
        ViewBag.Books = await _context.Books.Where(b => b.Status == "Available").ToListAsync();
        
        var model = new ReadingProgress
        {
            WeekStartDate = GetWeekStart(DateTime.UtcNow),
            TeacherId = userId
        };

        return View(model);
    }

    [HttpPost]
    [Authorize(Roles = "Coordinator,Teacher")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Create(ReadingProgress progress)
    {
        var userId = Guid.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);
        progress.TeacherId = userId;

        if (ModelState.IsValid)
        {
            try
            {
                await _readingService.CreateReadingProgressAsync(progress);
                await LogAudit("Create", progress.Id, "ReadingProgress");
                return RedirectToAction(nameof(Index));
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", ex.Message);
            }
        }

        var userRole = User.FindFirstValue("Role") ?? User.FindFirstValue(ClaimTypes.Role);
        ViewBag.Students = await GetAvailableStudentsAsync(userRole, userId);
        ViewBag.Books = await _context.Books.Where(b => b.Status == "Available").ToListAsync();
        return View(progress);
    }

    [Authorize(Roles = "Coordinator,Teacher")]
    public async Task<IActionResult> Edit(Guid id)
    {
        var progress = await _readingService.GetReadingProgressByIdAsync(id);
        if (progress == null) return NotFound();

        var userRole = User.FindFirstValue("Role") ?? User.FindFirstValue(ClaimTypes.Role);
        var userId = Guid.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);

        if (userRole != "Coordinator" && progress.TeacherId != userId)
            return Forbid();

        ViewBag.Students = await GetAvailableStudentsAsync(userRole, userId);
        ViewBag.Books = await _context.Books.Where(b => b.Status == "Available").ToListAsync();
        return View(progress);
    }

    [HttpPost]
    [Authorize(Roles = "Coordinator,Teacher")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Edit(ReadingProgress progress)
    {
        if (ModelState.IsValid)
        {
            await _readingService.UpdateReadingProgressAsync(progress);
            await LogAudit("Update", progress.Id, "ReadingProgress");
            return RedirectToAction(nameof(Index));
        }

        var userRole = User.FindFirstValue("Role") ?? User.FindFirstValue(ClaimTypes.Role);
        var userId = Guid.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);
        ViewBag.Students = await GetAvailableStudentsAsync(userRole, userId);
        ViewBag.Books = await _context.Books.Where(b => b.Status == "Available").ToListAsync();
        return View(progress);
    }

    [Authorize(Roles = "Coordinator")]
    public async Task<IActionResult> Delete(Guid id)
    {
        var progress = await _readingService.GetReadingProgressByIdAsync(id);
        if (progress == null) return NotFound();

        return View(progress);
    }

    [HttpPost, ActionName("Delete")]
    [Authorize(Roles = "Coordinator")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> DeleteConfirmed(Guid id)
    {
        await _readingService.DeleteReadingProgressAsync(id);
        await LogAudit("Delete", id, "ReadingProgress");
        return RedirectToAction(nameof(Index));
    }

    private async Task<List<Student>> GetAvailableStudentsAsync(string? role, Guid userId)
    {
        if (role == "Coordinator")
            return await _context.Students.Where(s => s.Status == "Active").ToListAsync();

        var classroomIds = await _teacherService.GetTeacherClassroomIdsAsync(userId);
        return await _context.Students
            .Where(s => s.Status == "Active" && classroomIds.Contains(s.ClassroomId))
            .ToListAsync();
    }

    private static DateOnly GetWeekStart(DateTime date)
    {
        var dayOfWeek = (int)date.DayOfWeek;
        var diff = dayOfWeek == 0 ? 6 : dayOfWeek - 1;
        return DateOnly.FromDateTime(date.AddDays(-diff));
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

