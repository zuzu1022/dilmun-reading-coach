using DilmunReadingCoach.Web.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace DilmunReadingCoach.Web.Controllers;

[Authorize]
public class ReportsController : Controller
{
    private readonly IReportService _reportService;
    private readonly ITeacherService _teacherService;

    public ReportsController(IReportService reportService, ITeacherService teacherService)
    {
        _reportService = reportService;
        _teacherService = teacherService;
    }

    [Authorize(Roles = "Coordinator,Teacher")]
    public IActionResult Weekly()
    {
        return View();
    }

    [HttpPost]
    [Authorize(Roles = "Coordinator,Teacher")]
    public async Task<IActionResult> WeeklyReport(Guid? classroomId, string weekStart, string format)
    {
        if (!DateOnly.TryParse(weekStart, out var weekStartDate))
        {
            ModelState.AddModelError("", "Invalid date format");
            return View("Weekly");
        }

        var userRole = User.FindFirstValue("Role") ?? User.FindFirstValue(ClaimTypes.Role);
        var userId = Guid.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);

        if (userRole == "Teacher")
        {
            var teacherClassroomIds = await _teacherService.GetTeacherClassroomIdsAsync(userId);
            if (classroomId.HasValue && !teacherClassroomIds.Contains(classroomId.Value))
                return Forbid();
        }

        byte[] content;
        string contentType;
        string fileName;

        if (format == "pdf")
        {
            content = await _reportService.GenerateWeeklyReportPdfAsync(classroomId, weekStartDate);
            contentType = "application/pdf";
            fileName = $"weekly_report_{weekStartDate:yyyyMMdd}.pdf";
        }
        else
        {
            content = await _reportService.GenerateWeeklyReportExcelAsync(classroomId, weekStartDate);
            contentType = "text/csv";
            fileName = $"weekly_report_{weekStartDate:yyyyMMdd}.csv";
        }

        return File(content, contentType, fileName);
    }

    [Authorize(Roles = "Coordinator")]
    public IActionResult Term()
    {
        return View();
    }

    [HttpPost]
    [Authorize(Roles = "Coordinator")]
    public async Task<IActionResult> TermReport(Guid? classroomId, string termStart, string termEnd, string format)
    {
        if (!DateOnly.TryParse(termStart, out var startDate) || !DateOnly.TryParse(termEnd, out var endDate))
        {
            ModelState.AddModelError("", "Invalid date format");
            return View("Term");
        }

        byte[] content;
        string contentType;
        string fileName;

        if (format == "pdf")
        {
            content = await _reportService.GenerateTermReportPdfAsync(startDate, endDate, classroomId);
            contentType = "application/pdf";
            fileName = $"term_report_{startDate:yyyyMMdd}_{endDate:yyyyMMdd}.pdf";
        }
        else
        {
            content = await _reportService.GenerateTermReportExcelAsync(startDate, endDate, classroomId);
            contentType = "text/csv";
            fileName = $"term_report_{startDate:yyyyMMdd}_{endDate:yyyyMMdd}.csv";
        }

        return File(content, contentType, fileName);
    }
}

