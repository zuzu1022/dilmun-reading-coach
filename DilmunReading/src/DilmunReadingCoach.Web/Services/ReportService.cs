using DilmunReadingCoach.Core.Entities;
using DilmunReadingCoach.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;
using QuestPDF.Fluent;
using QuestPDF.Helpers;
using QuestPDF.Infrastructure;
using System.Text;

namespace DilmunReadingCoach.Web.Services;

public class ReportService : IReportService
{
    private readonly ApplicationDbContext _context;
    private readonly IReadingService _readingService;

    private static bool _questPdfConfigured;

    public ReportService(ApplicationDbContext context, IReadingService readingService)
    {
        _context = context;
        _readingService = readingService;

        if (!_questPdfConfigured)
        {
            QuestPDF.Settings.License = LicenseType.Community;
            _questPdfConfigured = true;
        }
    }

    public async Task<byte[]> GenerateWeeklyReportPdfAsync(Guid? classroomId, DateOnly weekStart)
    {
        var records = await _readingService.GetReadingProgressAsync(classroomId: classroomId, weekStart: weekStart);
        return GenerateWeeklyReportPdf(records, weekStart, classroomId);
    }

    public async Task<byte[]> GenerateWeeklyReportExcelAsync(Guid? classroomId, DateOnly weekStart)
    {
        var records = await _readingService.GetReadingProgressAsync(classroomId: classroomId, weekStart: weekStart);
        
        var csv = new StringBuilder();
        csv.AppendLine("Student Name,Class,Book,Reading Level,Duration (Minutes),Notes,Week Start");
        
        foreach (var record in records)
        {
            csv.AppendLine($"{record.Student?.FirstName} {record.Student?.LastName}," +
                          $"{record.Student?.Classroom?.Name}," +
                          $"{record.Book?.Title ?? "N/A"}," +
                          $"{record.ReadingLevel}," +
                          $"{record.DurationMinutes}," +
                          $"\"{record.Notes ?? ""}\"," +
                          $"{record.WeekStartDate:yyyy-MM-dd}");
        }
        
        return Encoding.UTF8.GetBytes(csv.ToString());
    }

    public async Task<byte[]> GenerateTermReportPdfAsync(DateOnly termStart, DateOnly termEnd, Guid? classroomId)
    {
        var students = classroomId.HasValue
            ? await _context.Students.Where(s => s.ClassroomId == classroomId.Value).ToListAsync()
            : await _context.Students.ToListAsync();

        var records = await _context.ReadingProgress
            .Where(r => r.WeekStartDate >= termStart && r.WeekStartDate <= termEnd)
            .Where(r => classroomId == null || students.Any(s => s.Id == r.StudentId))
            .Include(r => r.Student)
                .ThenInclude(s => s!.Classroom)
            .Include(r => r.Book)
            .ToListAsync();

        return GenerateTermReportPdf(records, termStart, termEnd, classroomId);
    }

    public async Task<byte[]> GenerateTermReportExcelAsync(DateOnly termStart, DateOnly termEnd, Guid? classroomId)
    {
        var students = classroomId.HasValue
            ? await _context.Students.Where(s => s.ClassroomId == classroomId.Value).ToListAsync()
            : await _context.Students.ToListAsync();

        var records = await _context.ReadingProgress
            .Where(r => r.WeekStartDate >= termStart && r.WeekStartDate <= termEnd)
            .Where(r => classroomId == null || students.Any(s => s.Id == r.StudentId))
            .Include(r => r.Student)
                .ThenInclude(s => s!.Classroom)
            .Include(r => r.Book)
            .ToListAsync();

        var csv = new StringBuilder();
        csv.AppendLine("Student Name,Class,Book,Reading Level,Duration (Minutes),Notes,Week Start");
        
        foreach (var record in records)
        {
            csv.AppendLine($"{record.Student?.FirstName} {record.Student?.LastName}," +
                          $"{record.Student?.Classroom?.Name}," +
                          $"{record.Book?.Title ?? "N/A"}," +
                          $"{record.ReadingLevel}," +
                          $"{record.DurationMinutes}," +
                          $"\"{record.Notes ?? ""}\"," +
                          $"{record.WeekStartDate:yyyy-MM-dd}");
        }
        
        return Encoding.UTF8.GetBytes(csv.ToString());
    }

    private byte[] GenerateWeeklyReportPdf(List<ReadingProgress> records, DateOnly weekStart, Guid? classroomId)
    {
        return Document.Create(container =>
        {
            container.Page(page =>
            {
                page.Margin(40);
                page.Size(PageSizes.A4);
                page.PageColor(Colors.White);

                page.Header().Column(column =>
                {
                    column.Spacing(4);
                    column.Item().Text("Dilmun Reading Coach").Bold().FontSize(20).FontColor("#4F46E5");
                    column.Item().Text($"Weekly Reading Report - Week of {weekStart:yyyy-MM-dd}").FontSize(14);
                    if (classroomId.HasValue)
                    {
                        var classroomName = records.FirstOrDefault()?.Student?.Classroom?.Name ?? "Selected Classroom";
                        column.Item().Text($"Classroom: {classroomName}");
                    }
                    column.Item().Text($"Generated on {DateTime.UtcNow:yyyy-MM-dd HH:mm} UTC").FontSize(10).FontColor("#6B7280");
                });

                page.Content().PaddingVertical(10).Column(column =>
                {
                    column.Spacing(12);

                    column.Item().Row(row =>
                    {
                        row.Spacing(16);
                        row.RelativeItem().Text($"Total Entries: {records.Count}").Bold();
                        row.RelativeItem().Text($"Total Minutes: {records.Sum(r => r.DurationMinutes)}").Bold();
                    });

                    column.Item().Table(table =>
                    {
                        table.ColumnsDefinition(columns =>
                        {
                            columns.RelativeColumn(2); // Student
                            columns.RelativeColumn(1.5f); // Class
                            columns.RelativeColumn(2); // Book
                            columns.RelativeColumn(1); // Level
                            columns.RelativeColumn(1); // Minutes
                            columns.RelativeColumn(2); // Notes
                        });

                        table.Header(header =>
                        {
                            header.Cell().Element(HeaderCell).Text("Student");
                            header.Cell().Element(HeaderCell).Text("Class");
                            header.Cell().Element(HeaderCell).Text("Book");
                            header.Cell().Element(HeaderCell).Text("Level");
                            header.Cell().Element(HeaderCell).Text("Minutes");
                            header.Cell().Element(HeaderCell).Text("Notes");

                            static IContainer HeaderCell(IContainer container)
                            {
                                return container.DefaultTextStyle(x => x.SemiBold().FontColor(Colors.White))
                                    .Padding(6)
                                    .Background("#4F46E5");
                            }
                        });

                        foreach (var record in records.OrderBy(r => r.Student?.Classroom?.Name).ThenBy(r => r.Student?.LastName))
                        {
                            table.Cell().Element(Cell).Text($"{record.Student?.FirstName} {record.Student?.LastName}");
                            table.Cell().Element(Cell).Text(record.Student?.Classroom?.Name ?? "N/A");
                            table.Cell().Element(Cell).Text(record.Book?.Title ?? "N/A");
                            table.Cell().Element(Cell).Text(record.ReadingLevel);
                            table.Cell().Element(Cell).Text(record.DurationMinutes.ToString());
                            table.Cell().Element(Cell).Text(record.Notes ?? string.Empty);
                        }

                        static IContainer Cell(IContainer container)
                        {
                            return container.Padding(6)
                                .BorderBottom(0.5f)
                                .BorderColor("#E5E7EB");
                        }
                    });
                });

                page.Footer().AlignCenter().Text(text =>
                {
                    text.Span("Generated by Dilmun Reading Coach • ").FontSize(10).FontColor("#6B7280");
                    text.CurrentPageNumber();
                    text.Span(" / ");
                    text.TotalPages();
                });
            });
        }).GeneratePdf();
    }

    private byte[] GenerateTermReportPdf(List<ReadingProgress> records, DateOnly termStart, DateOnly termEnd, Guid? classroomId)
    {
        var totalMinutes = records.Sum(r => r.DurationMinutes);
        var groupedByClass = records
            .Where(r => r.Student?.Classroom != null)
            .GroupBy(r => r.Student!.Classroom!.Name)
            .Select(g => new { Classroom = g.Key, Minutes = g.Sum(r => r.DurationMinutes) })
            .OrderByDescending(g => g.Minutes)
            .ToList();

        return Document.Create(container =>
        {
            container.Page(page =>
            {
                page.Margin(40);
                page.Size(PageSizes.A4);
                page.PageColor(Colors.White);

                page.Header().Column(column =>
                {
                    column.Spacing(4);
                    column.Item().Text("Dilmun Reading Coach").Bold().FontSize(20).FontColor("#4F46E5");
                    column.Item().Text($"Term Reading Report - {termStart:yyyy-MM-dd} to {termEnd:yyyy-MM-dd}").FontSize(14);
                    if (classroomId.HasValue)
                    {
                        var classroomName = records.FirstOrDefault()?.Student?.Classroom?.Name ?? "Selected Classroom";
                        column.Item().Text($"Classroom: {classroomName}");
                    }
                    column.Item().Text($"Generated on {DateTime.UtcNow:yyyy-MM-dd HH:mm} UTC").FontSize(10).FontColor("#6B7280");
                });

                page.Content().PaddingVertical(10).Column(column =>
                {
                    column.Spacing(16);

                    column.Item().Row(row =>
                    {
                        row.Spacing(16);
                        row.RelativeItem().Text($"Total Entries: {records.Count}").Bold();
                        row.RelativeItem().Text($"Total Minutes: {totalMinutes}").Bold();
                    });

                    if (groupedByClass.Any())
                    {
                        column.Item().Border(1).BorderColor("#E5E7EB").Padding(10).Column(summary =>
                        {
                            summary.Spacing(6);
                            summary.Item().Text("Minutes by Classroom").SemiBold();
                            foreach (var item in groupedByClass)
                            {
                                summary.Item().Row(r =>
                                {
                                    r.RelativeItem().Text(item.Classroom);
                                    r.ConstantItem(80).AlignRight().Text(item.Minutes.ToString());
                                });
                            }
                        });
                    }

                    column.Item().Table(table =>
                    {
                        table.ColumnsDefinition(columns =>
                        {
                            columns.RelativeColumn(2); // Student
                            columns.RelativeColumn(1.2f); // Class
                            columns.RelativeColumn(2); // Book
                            columns.RelativeColumn(1); // Level
                            columns.RelativeColumn(1); // Minutes
                            columns.RelativeColumn(1.2f); // Week Start
                            columns.RelativeColumn(2); // Notes
                        });

                        table.Header(header =>
                        {
                            header.Cell().Element(HeaderCell).Text("Student");
                            header.Cell().Element(HeaderCell).Text("Class");
                            header.Cell().Element(HeaderCell).Text("Book");
                            header.Cell().Element(HeaderCell).Text("Level");
                            header.Cell().Element(HeaderCell).Text("Minutes");
                            header.Cell().Element(HeaderCell).Text("Week Start");
                            header.Cell().Element(HeaderCell).Text("Notes");

                            static IContainer HeaderCell(IContainer container)
                            {
                                return container.DefaultTextStyle(x => x.SemiBold().FontColor(Colors.White))
                                    .Padding(6)
                                    .Background("#2563EB");
                            }
                        });

                        foreach (var record in records.OrderBy(r => r.Student?.Classroom?.Name).ThenBy(r => r.Student?.LastName).ThenBy(r => r.WeekStartDate))
                        {
                            table.Cell().Element(Cell).Text($"{record.Student?.FirstName} {record.Student?.LastName}");
                            table.Cell().Element(Cell).Text(record.Student?.Classroom?.Name ?? "N/A");
                            table.Cell().Element(Cell).Text(record.Book?.Title ?? "N/A");
                            table.Cell().Element(Cell).Text(record.ReadingLevel);
                            table.Cell().Element(Cell).Text(record.DurationMinutes.ToString());
                            table.Cell().Element(Cell).Text(record.WeekStartDate.ToString("yyyy-MM-dd"));
                            table.Cell().Element(Cell).Text(record.Notes ?? string.Empty);
                        }

                        static IContainer Cell(IContainer container)
                        {
                            return container.Padding(6)
                                .BorderBottom(0.5f)
                                .BorderColor("#E5E7EB");
                        }
                    });
                });

                page.Footer().AlignCenter().Text(text =>
                {
                    text.Span("Generated by Dilmun Reading Coach • ").FontSize(10).FontColor("#6B7280");
                    text.CurrentPageNumber();
                    text.Span(" / ");
                    text.TotalPages();
                });
            });
        }).GeneratePdf();
    }
}

