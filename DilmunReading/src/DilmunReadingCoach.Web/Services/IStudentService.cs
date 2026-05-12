using DilmunReadingCoach.Core.Entities;

namespace DilmunReadingCoach.Web.Services;

public interface IStudentService
{
    Task<List<Student>> GetStudentsAsync(Guid? classroomId = null, string? searchTerm = null);
    Task<Student?> GetStudentByIdAsync(Guid id);
    Task<Student?> GetStudentByCodeAsync(string studentCode);
    Task<Student> CreateStudentAsync(Student student);
    Task<Student> UpdateStudentAsync(Student student);
    Task<bool> DeleteStudentAsync(Guid id);
    Task<(int success, int failed, List<string> errors)> BulkImportAsync(Stream csvStream);
    Task<List<Student>> GetStudentsByClassroomAsync(Guid classroomId);
}




