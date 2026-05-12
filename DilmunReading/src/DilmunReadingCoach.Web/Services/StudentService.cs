using DilmunReadingCoach.Core.Entities;
using DilmunReadingCoach.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;
using System.Globalization;
using System.Text;

namespace DilmunReadingCoach.Web.Services;

public class StudentService : IStudentService
{
    private readonly ApplicationDbContext _context;

    public StudentService(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<List<Student>> GetStudentsAsync(Guid? classroomId = null, string? searchTerm = null)
    {
        var query = _context.Students.Include(s => s.Classroom).AsQueryable();

        if (classroomId.HasValue)
            query = query.Where(s => s.ClassroomId == classroomId.Value);

        if (!string.IsNullOrWhiteSpace(searchTerm))
        {
            query = query.Where(s => 
                s.FirstName.Contains(searchTerm) || 
                s.LastName.Contains(searchTerm) || 
                s.StudentCode.Contains(searchTerm));
        }

        return await query.OrderBy(s => s.LastName).ThenBy(s => s.FirstName).ToListAsync();
    }

    public async Task<Student?> GetStudentByIdAsync(Guid id)
    {
        return await _context.Students
            .Include(s => s.Classroom)
            .FirstOrDefaultAsync(s => s.Id == id);
    }

    public async Task<Student?> GetStudentByCodeAsync(string studentCode)
    {
        return await _context.Students
            .FirstOrDefaultAsync(s => s.StudentCode == studentCode);
    }

    public async Task<Student> CreateStudentAsync(Student student)
    {
        student.Id = Guid.NewGuid();
        student.CreatedAtUtc = DateTime.UtcNow;
        _context.Students.Add(student);
        await _context.SaveChangesAsync();
        return student;
    }

    public async Task<Student> UpdateStudentAsync(Student student)
    {
        student.UpdatedAtUtc = DateTime.UtcNow;
        _context.Students.Update(student);
        await _context.SaveChangesAsync();
        return student;
    }

    public async Task<bool> DeleteStudentAsync(Guid id)
    {
        var student = await _context.Students.FindAsync(id);
        if (student == null) return false;

        student.Status = "Inactive";
        student.UpdatedAtUtc = DateTime.UtcNow;
        await _context.SaveChangesAsync();
        return true;
    }

    public async Task<(int success, int failed, List<string> errors)> BulkImportAsync(Stream csvStream)
    {
        var errors = new List<string>();
        int success = 0, failed = 0;

        using var reader = new StreamReader(csvStream, Encoding.UTF8);
        var lines = new List<string>();
        while (!reader.EndOfStream)
            lines.Add(reader.ReadLine() ?? "");

        if (lines.Count < 2) return (0, 0, new List<string> { "CSV file must have a header row and at least one data row" });

        var header = lines[0].Split(',');
        var expectedHeaders = new[] { "StudentCode", "FirstName", "LastName", "Gender", "DateOfBirth", "ClassroomName", "ReadingLevel" };

        for (int i = 1; i < lines.Count; i++)
        {
            try
            {
                var values = lines[i].Split(',');
                if (values.Length < 3) { failed++; errors.Add($"Row {i + 1}: Insufficient columns"); continue; }

                var studentCode = values[0].Trim();
                if (string.IsNullOrEmpty(studentCode)) { failed++; errors.Add($"Row {i + 1}: StudentCode is required"); continue; }

                var existing = await GetStudentByCodeAsync(studentCode);
                if (existing != null) { failed++; errors.Add($"Row {i + 1}: StudentCode {studentCode} already exists"); continue; }

                var classroomName = values.Length > 5 ? values[5].Trim() : "";
                var classroom = await _context.Classrooms.FirstOrDefaultAsync(c => c.Name == classroomName);
                if (classroom == null) { failed++; errors.Add($"Row {i + 1}: Classroom '{classroomName}' not found"); continue; }

                var student = new Student
                {
                    StudentCode = studentCode,
                    FirstName = values[1].Trim(),
                    LastName = values[2].Trim(),
                    Gender = values.Length > 3 ? values[3].Trim() : null,
                    DateOfBirth = values.Length > 4 && DateTime.TryParse(values[4].Trim(), out var dob) ? dob : null,
                    ClassroomId = classroom.Id,
                    ReadingLevel = values.Length > 6 ? values[6].Trim() : "",
                    Status = "Active"
                };

                await CreateStudentAsync(student);
                success++;
            }
            catch (Exception ex)
            {
                failed++;
                errors.Add($"Row {i + 1}: {ex.Message}");
            }
        }

        return (success, failed, errors);
    }

    public async Task<List<Student>> GetStudentsByClassroomAsync(Guid classroomId)
    {
        return await _context.Students
            .Where(s => s.ClassroomId == classroomId && s.Status == "Active")
            .OrderBy(s => s.LastName)
            .ThenBy(s => s.FirstName)
            .ToListAsync();
    }
}

