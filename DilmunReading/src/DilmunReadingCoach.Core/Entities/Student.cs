using System;

namespace DilmunReadingCoach.Core.Entities;

public class Student : BaseAuditableEntity
{
    public string StudentCode { get; set; } = string.Empty;
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public string? Gender { get; set; }
    public DateTime? DateOfBirth { get; set; }
    public Guid ClassroomId { get; set; }
    public string ReadingLevel { get; set; } = string.Empty;
    public string Status { get; set; } = "Active";
    public Classroom? Classroom { get; set; }
}

