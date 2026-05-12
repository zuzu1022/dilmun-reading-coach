using DilmunReadingCoach.Web.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace DilmunReadingCoach.Web.Controllers;

[Authorize]
public class DashboardController : Controller
{
    private readonly IDashboardService _dashboardService;

    public DashboardController(IDashboardService dashboardService)
    {
        _dashboardService = dashboardService;
    }

    [Authorize(Roles = "Coordinator")]
    public async Task<IActionResult> Coordinator()
    {
        var viewModel = await _dashboardService.GetCoordinatorDashboardAsync();
        return View(viewModel);
    }

    [Authorize(Roles = "Teacher")]
    public async Task<IActionResult> Teacher()
    {
        var userId = Guid.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);
        var viewModel = await _dashboardService.GetTeacherDashboardAsync(userId);
        return View(viewModel);
    }
}

