using DilmunReadingCoach.Infrastructure.Data;
using DilmunReadingCoach.Infrastructure.Identity;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace DilmunReadingCoach.Web.Services;

public class TeacherService : ITeacherService
{
    private readonly ApplicationDbContext _context;
    private readonly UserManager<ApplicationUser> _userManager;

    public TeacherService(ApplicationDbContext context, UserManager<ApplicationUser> userManager)
    {
        _context = context;
        _userManager = userManager;
    }

    public async Task<List<ApplicationUser>> GetTeachersAsync()
    {
        return await _userManager.GetUsersInRoleAsync("Teacher") as List<ApplicationUser> ?? new List<ApplicationUser>();
    }

    public async Task<ApplicationUser?> GetTeacherByIdAsync(Guid id)
    {
        return await _userManager.FindByIdAsync(id.ToString());
    }

    public async Task<ApplicationUser> CreateTeacherAsync(ApplicationUser teacher, string password)
    {
        teacher.Id = Guid.NewGuid();
        teacher.Role = "Teacher";
        teacher.IsActive = true;
        teacher.CreatedAtUtc = DateTime.UtcNow;
        teacher.UserName = teacher.UserName?.ToLowerInvariant();
        teacher.Email = teacher.Email?.ToLowerInvariant();

        var result = await _userManager.CreateAsync(teacher, password);
        if (!result.Succeeded)
            throw new InvalidOperationException(string.Join(", ", result.Errors.Select(e => e.Description)));

        await _userManager.AddToRoleAsync(teacher, "Teacher");
        return teacher;
    }

    public async Task<ApplicationUser> UpdateTeacherAsync(ApplicationUser teacher)
    {
        teacher.UpdatedAtUtc = DateTime.UtcNow;
        await _userManager.UpdateAsync(teacher);
        return teacher;
    }

    public async Task<bool> DeleteTeacherAsync(Guid id)
    {
        var teacher = await _userManager.FindByIdAsync(id.ToString());
        if (teacher == null) return false;

        teacher.IsActive = false;
        teacher.UpdatedAtUtc = DateTime.UtcNow;
        await _userManager.UpdateAsync(teacher);
        return true;
    }

    public async Task<List<Guid>> GetTeacherClassroomIdsAsync(Guid teacherId)
    {
        return await _context.TeacherClasses
            .Where(tc => tc.TeacherId == teacherId)
            .Select(tc => tc.ClassroomId)
            .ToListAsync();
    }

    public async Task AssignClassroomsAsync(Guid teacherId, List<Guid> classroomIds)
    {
        var existing = await _context.TeacherClasses
            .Where(tc => tc.TeacherId == teacherId)
            .ToListAsync();

        _context.TeacherClasses.RemoveRange(existing);

        foreach (var classroomId in classroomIds)
        {
            _context.TeacherClasses.Add(new Core.Entities.TeacherClass
            {
                TeacherId = teacherId,
                ClassroomId = classroomId
            });
        }

        await _context.SaveChangesAsync();
    }
}

