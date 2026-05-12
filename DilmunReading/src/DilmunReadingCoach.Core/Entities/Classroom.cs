using System;

namespace DilmunReadingCoach.Core.Entities;

public class Classroom : BaseAuditableEntity
{
    public string Name { get; set; } = string.Empty;
    public string? YearGroup { get; set; }
    public string Status { get; set; } = "Active";
}

