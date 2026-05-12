using DilmunReadingCoach.Infrastructure.Identity;

namespace DilmunReadingCoach.Web.Services;

public interface ITeacherService
{
    Task<List<ApplicationUser>> GetTeachersAsync();
    Task<ApplicationUser?> GetTeacherByIdAsync(Guid id);
    Task<ApplicationUser> CreateTeacherAsync(ApplicationUser teacher, string password);
    Task<ApplicationUser> UpdateTeacherAsync(ApplicationUser teacher);
    Task<bool> DeleteTeacherAsync(Guid id);
    Task<List<Guid>> GetTeacherClassroomIdsAsync(Guid teacherId);
    Task AssignClassroomsAsync(Guid teacherId, List<Guid> classroomIds);
}

