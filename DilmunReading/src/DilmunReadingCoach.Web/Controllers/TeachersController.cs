using DilmunReadingCoach.Infrastructure.Data;
using DilmunReadingCoach.Infrastructure.Identity;
using DilmunReadingCoach.Web.Models;
using DilmunReadingCoach.Web.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace DilmunReadingCoach.Web.Controllers;

[Authorize(Roles = "Coordinator")]
public class TeachersController : Controller
{
    private readonly ITeacherService _teacherService;
    private readonly IAuditService _auditService;
    private readonly ApplicationDbContext _context;

    public TeachersController(
        ITeacherService teacherService,
        IAuditService auditService,
        ApplicationDbContext context)
    {
        _teacherService = teacherService;
        _auditService = auditService;
        _context = context;
    }

    public async Task<IActionResult> Index()
    {
        var teachers = await _teacherService.GetTeachersAsync();
        return View(teachers);
    }

    public async Task<IActionResult> Create()
    {
        ViewBag.Classrooms = await _context.Classrooms.Where(c => c.Status == "Active").ToListAsync();
        return View();
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Create(CreateTeacherViewModel model)
    {
        if (ModelState.IsValid)
        {
            try
            {
                var teacher = new ApplicationUser
                {
                    UserName = model.Username,
                    FirstName = model.FirstName,
                    LastName = model.LastName,
                    Email = model.Email,
                    PhoneNumber = model.Phone
                };

                await _teacherService.CreateTeacherAsync(teacher, model.Password);
                
                if (model.ClassroomIds != null && model.ClassroomIds.Any())
                {
                    await _teacherService.AssignClassroomsAsync(teacher.Id, model.ClassroomIds);
                }

                await LogAudit("Create", teacher.Id, "Teacher");
                return RedirectToAction(nameof(Index));
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", ex.Message);
            }
        }

        ViewBag.Classrooms = await _context.Classrooms.Where(c => c.Status == "Active").ToListAsync();
        return View(model);
    }

    public async Task<IActionResult> Edit(Guid id)
    {
        var teacher = await _teacherService.GetTeacherByIdAsync(id);
        if (teacher == null) return NotFound();

        var classroomIds = await _teacherService.GetTeacherClassroomIdsAsync(id);
        ViewBag.Classrooms = await _context.Classrooms.Where(c => c.Status == "Active").ToListAsync();
        ViewBag.SelectedClassrooms = classroomIds;

        var model = new EditTeacherViewModel
        {
            Id = teacher.Id,
            Username = teacher.UserName!,
            FirstName = teacher.FirstName,
            LastName = teacher.LastName,
            Email = teacher.Email!,
            Phone = teacher.PhoneNumber,
            IsActive = teacher.IsActive
        };

        return View(model);
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Edit(EditTeacherViewModel model)
    {
        if (ModelState.IsValid)
        {
            var teacher = await _teacherService.GetTeacherByIdAsync(model.Id);
            if (teacher == null) return NotFound();

            teacher.FirstName = model.FirstName;
            teacher.LastName = model.LastName;
            teacher.Email = model.Email;
            teacher.PhoneNumber = model.Phone;
            teacher.IsActive = model.IsActive;

            await _teacherService.UpdateTeacherAsync(teacher);
            
            if (model.ClassroomIds != null)
            {
                await _teacherService.AssignClassroomsAsync(teacher.Id, model.ClassroomIds);
            }

            await LogAudit("Update", teacher.Id, "Teacher");
            return RedirectToAction(nameof(Index));
        }

        ViewBag.Classrooms = await _context.Classrooms.Where(c => c.Status == "Active").ToListAsync();
        return View(model);
    }

    public async Task<IActionResult> Delete(Guid id)
    {
        var teacher = await _teacherService.GetTeacherByIdAsync(id);
        if (teacher == null) return NotFound();

        return View(teacher);
    }

    [HttpPost, ActionName("Delete")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> DeleteConfirmed(Guid id)
    {
        await _teacherService.DeleteTeacherAsync(id);
        await LogAudit("Delete", id, "Teacher");
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
