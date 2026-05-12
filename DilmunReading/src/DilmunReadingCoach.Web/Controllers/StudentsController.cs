using DilmunReadingCoach.Core.Entities;
using DilmunReadingCoach.Infrastructure.Data;
using DilmunReadingCoach.Web.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace DilmunReadingCoach.Web.Controllers;

[Authorize]
public class StudentsController : Controller
{
    private readonly IStudentService _studentService;
    private readonly IAuditService _auditService;
    private readonly ApplicationDbContext _context;
    private readonly ITeacherService _teacherService;

    public StudentsController(
        IStudentService studentService,
        IAuditService auditService,
        ApplicationDbContext context,
        ITeacherService teacherService)
    {
        _studentService = studentService;
        _auditService = auditService;
        _context = context;
        _teacherService = teacherService;
    }

    [Authorize(Roles = "Coordinator,Teacher")]
    public async Task<IActionResult> Index(string? searchTerm, Guid? classroomId)
    {
        var userRole = User.FindFirstValue("Role") ?? User.FindFirstValue(ClaimTypes.Role);
        var userId = Guid.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);

        List<Student> students;

        if (userRole == "Coordinator")
        {
            students = await _studentService.GetStudentsAsync(classroomId, searchTerm);
        }
        else
        {
            var teacherClassroomIds = await _teacherService.GetTeacherClassroomIdsAsync(userId);
            students = await _studentService.GetStudentsAsync(null, searchTerm);
            students = students.Where(s => teacherClassroomIds.Contains(s.ClassroomId)).ToList();
        }

        ViewBag.Classrooms = await _context.Classrooms.Where(c => c.Status == "Active").ToListAsync();
        return View(students);
    }

    [Authorize(Roles = "Coordinator")]
    public async Task<IActionResult> Create()
    {
        ViewBag.Classrooms = await _context.Classrooms.Where(c => c.Status == "Active").ToListAsync();
        return View();
    }

    [HttpPost]
    [Authorize(Roles = "Coordinator")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Create(Student student)
    {
        if (ModelState.IsValid)
        {
            try
            {
                await _studentService.CreateStudentAsync(student);
                await LogAudit("Create", student.Id, "Student");
                return RedirectToAction(nameof(Index));
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", ex.Message);
            }
        }

        ViewBag.Classrooms = await _context.Classrooms.Where(c => c.Status == "Active").ToListAsync();
        return View(student);
    }

    [Authorize(Roles = "Coordinator")]
    public async Task<IActionResult> Edit(Guid id)
    {
        var student = await _studentService.GetStudentByIdAsync(id);
        if (student == null) return NotFound();

        ViewBag.Classrooms = await _context.Classrooms.Where(c => c.Status == "Active").ToListAsync();
        return View(student);
    }

    [HttpPost]
    [Authorize(Roles = "Coordinator")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Edit(Student student)
    {
        if (ModelState.IsValid)
        {
            await _studentService.UpdateStudentAsync(student);
            await LogAudit("Update", student.Id, "Student");
            return RedirectToAction(nameof(Index));
        }

        ViewBag.Classrooms = await _context.Classrooms.Where(c => c.Status == "Active").ToListAsync();
        return View(student);
    }

    [Authorize(Roles = "Coordinator")]
    public async Task<IActionResult> Delete(Guid id)
    {
        var student = await _studentService.GetStudentByIdAsync(id);
        if (student == null) return NotFound();

        return View(student);
    }

    [HttpPost, ActionName("Delete")]
    [Authorize(Roles = "Coordinator")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> DeleteConfirmed(Guid id)
    {
        await _studentService.DeleteStudentAsync(id);
        await LogAudit("Delete", id, "Student");
        return RedirectToAction(nameof(Index));
    }

    [Authorize(Roles = "Coordinator")]
    public IActionResult BulkImport()
    {
        return View();
    }

    [HttpPost]
    [Authorize(Roles = "Coordinator")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> BulkImport(IFormFile file)
    {
        if (file == null || file.Length == 0)
        {
            ModelState.AddModelError("", "Please select a file.");
            return View();
        }

        using var stream = file.OpenReadStream();
        var (success, failed, errors) = await _studentService.BulkImportAsync(stream);

        ViewBag.Success = success;
        ViewBag.Failed = failed;
        ViewBag.Errors = errors;

        return View();
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

