using System.ComponentModel.DataAnnotations;

namespace DilmunReadingCoach.Web.Models;

public class EditTeacherViewModel
{
    public Guid Id { get; set; }
    
    [Required]
    public string Username { get; set; } = string.Empty;
    
    [Required]
    public string FirstName { get; set; } = string.Empty;
    
    [Required]
    public string LastName { get; set; } = string.Empty;
    
    [EmailAddress]
    public string? Email { get; set; }
    
    public string? Phone { get; set; }
    
    public bool IsActive { get; set; }
    
    public List<Guid>? ClassroomIds { get; set; }
}

