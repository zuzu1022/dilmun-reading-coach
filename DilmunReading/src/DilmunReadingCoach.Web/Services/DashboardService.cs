using DilmunReadingCoach.Core.Entities;
using DilmunReadingCoach.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;
using System.Text.Json;

namespace DilmunReadingCoach.Web.Services;

public class DashboardService : IDashboardService
{
    private readonly ApplicationDbContext _context;
    private static readonly TimeSpan CacheExpiry = TimeSpan.FromHours(1);

    public DashboardService(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<CoordinatorDashboardViewModel> GetCoordinatorDashboardAsync()
    {
        // Try to get from cache first
        var cached = await _context.ReportCaches
            .Where(c => c.ReportType == "Dashboard" && c.ScopeId == null)
            .OrderByDescending(c => c.CreatedAtUtc)
            .FirstOrDefaultAsync();

        if (cached != null && cached.CreatedAtUtc > DateTime.UtcNow.Add(-CacheExpiry))
        {
            try
            {
                return JsonSerializer.Deserialize<CoordinatorDashboardViewModel>(cached.PayloadJson) 
                    ?? await BuildCoordinatorDashboardAsync();
            }
            catch
            {
                // If deserialization fails, rebuild
            }
        }

        var viewModel = await BuildCoordinatorDashboardAsync();
        
        // Cache the result
        await CacheDashboardAsync(viewModel, null);
        
        return viewModel;
    }

    private async Task<CoordinatorDashboardViewModel> BuildCoordinatorDashboardAsync()
    {
        var students = await _context.Students.ToListAsync();
        var records = await _context.ReadingProgress.ToListAsync();
        var classrooms = await _context.Classrooms.ToListAsync();

        var currentWeekStart = GetWeekStart(DateTime.UtcNow);
        var currentDate = DateTime.UtcNow;
        var termStart = new DateTime(currentDate.Year, currentDate.Month >= 9 ? 9 : 1, 1); // September or January
        var termEnd = termStart.AddMonths(4).AddDays(-1); // 4 months later

        var viewModel = new CoordinatorDashboardViewModel
        {
            TotalStudents = students.Count,
            ActiveStudents = students.Count(s => s.Status == "Active"),
            TotalReadingRecords = records.Count,
            TotalReadingMinutes = records.Sum(r => r.DurationMinutes),
            CurrentTermMinutes = records
                .Where(r => r.WeekStartDate >= DateOnly.FromDateTime(termStart) && 
                           r.WeekStartDate <= DateOnly.FromDateTime(termEnd))
                .Sum(r => r.DurationMinutes),
            ReadingLevelDistribution = records
                .GroupBy(r => r.ReadingLevel)
                .ToDictionary(g => g.Key, g => g.Count())
        };

        // Class summaries
        foreach (var classroom in classrooms.Where(c => c.Status == "Active"))
        {
            var classStudents = students.Where(s => s.ClassroomId == classroom.Id && s.Status == "Active").ToList();
            var classRecords = records.Where(r => classStudents.Any(s => s.Id == r.StudentId)).ToList();
            
            var avgLevel = classRecords.Any() 
                ? classRecords.GroupBy(r => r.ReadingLevel)
                    .OrderByDescending(g => g.Count())
                    .FirstOrDefault()?.Key ?? "N/A"
                : "N/A";

            viewModel.ClassSummaries.Add(new ClassSummaryViewModel
            {
                ClassId = classroom.Id,
                ClassName = classroom.Name,
                StudentCount = classStudents.Count,
                RecordCount = classRecords.Count,
                TotalMinutes = classRecords.Sum(r => r.DurationMinutes),
                AverageReadingLevel = avgLevel
            });
        }

        // Missing entries for current week
        var studentsWithoutEntry = await _context.Students
            .Where(s => s.Status == "Active")
            .Where(s => !_context.ReadingProgress.Any(r => r.StudentId == s.Id && r.WeekStartDate == currentWeekStart))
            .Include(s => s.Classroom)
            .ToListAsync();

        viewModel.MissingEntries = studentsWithoutEntry.Select(s => new MissingEntryViewModel
        {
            StudentId = s.Id,
            StudentName = $"{s.FirstName} {s.LastName}",
            ClassName = s.Classroom?.Name ?? "Unknown",
            WeekStart = currentWeekStart
        }).ToList();

        return viewModel;
    }

    private async Task CacheDashboardAsync(CoordinatorDashboardViewModel viewModel, Guid? scopeId)
    {
        var json = JsonSerializer.Serialize(viewModel);
        var cache = new ReportCache
        {
            Id = Guid.NewGuid(),
            ReportType = "Dashboard",
            ScopeId = scopeId,
            PeriodStart = DateOnly.FromDateTime(DateTime.UtcNow),
            PeriodEnd = DateOnly.FromDateTime(DateTime.UtcNow),
            PayloadJson = json,
            CreatedAtUtc = DateTime.UtcNow
        };
        _context.ReportCaches.Add(cache);
        
        // Remove old cache entries (keep last 10)
        var oldCaches = await _context.ReportCaches
            .Where(c => c.ReportType == "Dashboard" && c.ScopeId == scopeId)
            .OrderByDescending(c => c.CreatedAtUtc)
            .Skip(10)
            .ToListAsync();
        _context.ReportCaches.RemoveRange(oldCaches);
        
        await _context.SaveChangesAsync();
    }

    public async Task<TeacherDashboardViewModel> GetTeacherDashboardAsync(Guid teacherId)
    {
        // Try to get from cache first
        var cached = await _context.ReportCaches
            .Where(c => c.ReportType == "Dashboard" && c.ScopeId == teacherId)
            .OrderByDescending(c => c.CreatedAtUtc)
            .FirstOrDefaultAsync();

        if (cached != null && cached.CreatedAtUtc > DateTime.UtcNow.Add(-CacheExpiry))
        {
            try
            {
                return JsonSerializer.Deserialize<TeacherDashboardViewModel>(cached.PayloadJson) 
                    ?? await BuildTeacherDashboardAsync(teacherId);
            }
            catch
            {
                // If deserialization fails, rebuild
            }
        }

        var viewModel = await BuildTeacherDashboardAsync(teacherId);
        
        // Cache the result
        await CacheTeacherDashboardAsync(viewModel, teacherId);
        
        return viewModel;
    }

    private async Task<TeacherDashboardViewModel> BuildTeacherDashboardAsync(Guid teacherId)
    {
        var teacherClasses = await _context.TeacherClasses
            .Where(tc => tc.TeacherId == teacherId)
            .Select(tc => tc.ClassroomId)
            .ToListAsync();

        var students = await _context.Students
            .Where(s => teacherClasses.Contains(s.ClassroomId) && s.Status == "Active")
            .Include(s => s.Classroom)
            .ToListAsync();

        var studentIds = students.Select(s => s.Id).ToList();
        var records = await _context.ReadingProgress
            .Where(r => studentIds.Contains(r.StudentId))
            .ToListAsync();

        var classrooms = await _context.Classrooms
            .Where(c => teacherClasses.Contains(c.Id))
            .ToListAsync();

        var currentWeekStart = GetWeekStart(DateTime.UtcNow);

        var viewModel = new TeacherDashboardViewModel
        {
            TotalStudents = students.Count,
            TotalReadingRecords = records.Count,
            TotalReadingMinutes = records.Sum(r => r.DurationMinutes)
        };

        // Class summaries for teacher's classes
        foreach (var classroom in classrooms.Where(c => c.Status == "Active"))
        {
            var classStudents = students.Where(s => s.ClassroomId == classroom.Id).ToList();
            var classRecords = records.Where(r => classStudents.Any(s => s.Id == r.StudentId)).ToList();

            var avgLevel = classRecords.Any()
                ? classRecords.GroupBy(r => r.ReadingLevel)
                    .OrderByDescending(g => g.Count())
                    .FirstOrDefault()?.Key ?? "N/A"
                : "N/A";

            viewModel.ClassSummaries.Add(new ClassSummaryViewModel
            {
                ClassId = classroom.Id,
                ClassName = classroom.Name,
                StudentCount = classStudents.Count,
                RecordCount = classRecords.Count,
                TotalMinutes = classRecords.Sum(r => r.DurationMinutes),
                AverageReadingLevel = avgLevel
            });
        }

        // Missing entries for current week
        var studentsWithoutEntry = await _context.Students
            .Where(s => teacherClasses.Contains(s.ClassroomId) && s.Status == "Active")
            .Where(s => !_context.ReadingProgress.Any(r => r.StudentId == s.Id && r.WeekStartDate == currentWeekStart))
            .Include(s => s.Classroom)
            .ToListAsync();

        viewModel.MissingEntries = studentsWithoutEntry.Select(s => new MissingEntryViewModel
        {
            StudentId = s.Id,
            StudentName = $"{s.FirstName} {s.LastName}",
            ClassName = s.Classroom?.Name ?? "Unknown",
            WeekStart = currentWeekStart
        }).ToList();

        // Last reading level per student
        var studentLastReadings = new List<StudentLastReadingViewModel>();
        foreach (var student in students)
        {
            var lastRecord = records
                .Where(r => r.StudentId == student.Id)
                .OrderByDescending(r => r.WeekStartDate)
                .FirstOrDefault();

            studentLastReadings.Add(new StudentLastReadingViewModel
            {
                StudentId = student.Id,
                StudentName = $"{student.FirstName} {student.LastName}",
                ClassName = student.Classroom?.Name ?? "Unknown",
                LastReadingLevel = lastRecord?.ReadingLevel ?? student.ReadingLevel ?? "N/A",
                LastReadingDate = lastRecord?.WeekStartDate
            });
        }

        viewModel.StudentLastReadings = studentLastReadings.OrderBy(s => s.ClassName).ThenBy(s => s.StudentName).ToList();

        return viewModel;
    }

    private async Task CacheTeacherDashboardAsync(TeacherDashboardViewModel viewModel, Guid teacherId)
    {
        var json = JsonSerializer.Serialize(viewModel);
        var cache = new ReportCache
        {
            Id = Guid.NewGuid(),
            ReportType = "Dashboard",
            ScopeId = teacherId,
            PeriodStart = DateOnly.FromDateTime(DateTime.UtcNow),
            PeriodEnd = DateOnly.FromDateTime(DateTime.UtcNow),
            PayloadJson = json,
            CreatedAtUtc = DateTime.UtcNow
        };
        _context.ReportCaches.Add(cache);
        
        // Remove old cache entries (keep last 10)
        var oldCaches = await _context.ReportCaches
            .Where(c => c.ReportType == "Dashboard" && c.ScopeId == teacherId)
            .OrderByDescending(c => c.CreatedAtUtc)
            .Skip(10)
            .ToListAsync();
        _context.ReportCaches.RemoveRange(oldCaches);
        
        await _context.SaveChangesAsync();
    }

    private static DateOnly GetWeekStart(DateTime date)
    {
        var dayOfWeek = (int)date.DayOfWeek;
        var diff = dayOfWeek == 0 ? 6 : dayOfWeek - 1; // Monday = 0
        return DateOnly.FromDateTime(date.AddDays(-diff));
    }
}

