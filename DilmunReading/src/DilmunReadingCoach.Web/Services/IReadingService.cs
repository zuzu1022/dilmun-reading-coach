using DilmunReadingCoach.Core.Entities;

namespace DilmunReadingCoach.Web.Services;

public interface IReadingService
{
    Task<List<ReadingProgress>> GetReadingProgressAsync(Guid? studentId = null, Guid? classroomId = null, DateOnly? weekStart = null);
    Task<ReadingProgress?> GetReadingProgressByIdAsync(Guid id);
    Task<ReadingProgress> CreateReadingProgressAsync(ReadingProgress progress);
    Task<ReadingProgress> UpdateReadingProgressAsync(ReadingProgress progress);
    Task<bool> DeleteReadingProgressAsync(Guid id);
    Task<bool> HasEntryForWeekAsync(Guid studentId, DateOnly weekStart);
    Task<List<Student>> GetStudentsWithoutEntryAsync(Guid classroomId, DateOnly weekStart);
}

