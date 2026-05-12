namespace DilmunReadingCoach.Web.Services;

public interface IReportService
{
    Task<byte[]> GenerateWeeklyReportPdfAsync(Guid? classroomId, DateOnly weekStart);
    Task<byte[]> GenerateWeeklyReportExcelAsync(Guid? classroomId, DateOnly weekStart);
    Task<byte[]> GenerateTermReportPdfAsync(DateOnly termStart, DateOnly termEnd, Guid? classroomId);
    Task<byte[]> GenerateTermReportExcelAsync(DateOnly termStart, DateOnly termEnd, Guid? classroomId);
}

