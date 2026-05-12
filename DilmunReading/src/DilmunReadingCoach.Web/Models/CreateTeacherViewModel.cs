using System.ComponentModel.DataAnnotations;

namespace DilmunReadingCoach.Web.Models;

public class CreateTeacherViewModel
{
    [Required]
    public string Username { get; set; } = string.Empty;
    
    [Required]
    [DataType(DataType.Password)]
    public string Password { get; set; } = string.Empty;
    
    [Required]
    public string FirstName { get; set; } = string.Empty;
    
    [Required]
    public string LastName { get; set; } = string.Empty;
    
    [EmailAddress]
    public string? Email { get; set; }
    
    public string? Phone { get; set; }
    
    public List<Guid>? ClassroomIds { get; set; }
}

