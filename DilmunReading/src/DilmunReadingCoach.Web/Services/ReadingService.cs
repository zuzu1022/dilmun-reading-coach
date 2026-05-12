using DilmunReadingCoach.Core.Entities;
using DilmunReadingCoach.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace DilmunReadingCoach.Web.Services;

public class ReadingService : IReadingService
{
    private readonly ApplicationDbContext _context;

    public ReadingService(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<List<ReadingProgress>> GetReadingProgressAsync(Guid? studentId = null, Guid? classroomId = null, DateOnly? weekStart = null)
    {
        var query = _context.ReadingProgress
            .Include(r => r.Student)
                .ThenInclude(s => s!.Classroom)
            .Include(r => r.Book)
            .AsQueryable();

        if (studentId.HasValue)
            query = query.Where(r => r.StudentId == studentId.Value);

        if (classroomId.HasValue)
            query = query.Where(r => r.Student!.ClassroomId == classroomId.Value);

        if (weekStart.HasValue)
            query = query.Where(r => r.WeekStartDate == weekStart.Value);

        return await query.OrderByDescending(r => r.WeekStartDate).ThenBy(r => r.Student!.LastName).ToListAsync();
    }

    public async Task<ReadingProgress?> GetReadingProgressByIdAsync(Guid id)
    {
        return await _context.ReadingProgress
            .Include(r => r.Student)
                .ThenInclude(s => s!.Classroom)
            .Include(r => r.Book)
            .FirstOrDefaultAsync(r => r.Id == id);
    }

    public async Task<ReadingProgress> CreateReadingProgressAsync(ReadingProgress progress)
    {
        if (await HasEntryForWeekAsync(progress.StudentId, progress.WeekStartDate))
            throw new InvalidOperationException($"Reading entry already exists for this student and week");

        progress.Id = Guid.NewGuid();
        progress.CreatedAtUtc = DateTime.UtcNow;
        _context.ReadingProgress.Add(progress);
        await _context.SaveChangesAsync();
        return progress;
    }

    public async Task<ReadingProgress> UpdateReadingProgressAsync(ReadingProgress progress)
    {
        progress.UpdatedAtUtc = DateTime.UtcNow;
        _context.ReadingProgress.Update(progress);
        await _context.SaveChangesAsync();
        return progress;
    }

    public async Task<bool> DeleteReadingProgressAsync(Guid id)
    {
        var progress = await _context.ReadingProgress.FindAsync(id);
        if (progress == null) return false;

        _context.ReadingProgress.Remove(progress);
        await _context.SaveChangesAsync();
        return true;
    }

    public async Task<bool> HasEntryForWeekAsync(Guid studentId, DateOnly weekStart)
    {
        return await _context.ReadingProgress
            .AnyAsync(r => r.StudentId == studentId && r.WeekStartDate == weekStart);
    }

    public async Task<List<Student>> GetStudentsWithoutEntryAsync(Guid classroomId, DateOnly weekStart)
    {
        var studentsWithEntry = await _context.ReadingProgress
            .Where(r => r.WeekStartDate == weekStart && r.Student!.ClassroomId == classroomId)
            .Select(r => r.StudentId)
            .ToListAsync();

        return await _context.Students
            .Where(s => s.ClassroomId == classroomId && 
                       s.Status == "Active" && 
                       !studentsWithEntry.Contains(s.Id))
            .OrderBy(s => s.LastName)
            .ThenBy(s => s.FirstName)
            .ToListAsync();
    }
}

