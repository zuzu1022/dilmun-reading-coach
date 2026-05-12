using System;

namespace DilmunReadingCoach.Core.Entities;

public class ReadingProgress : BaseAuditableEntity
{
    public Guid StudentId { get; set; }
    public Guid TeacherId { get; set; }
    public Guid? BookId { get; set; }
    public DateOnly WeekStartDate { get; set; }
    public string ReadingLevel { get; set; } = string.Empty;
    public int DurationMinutes { get; set; }
    public string? Notes { get; set; }

    public Student? Student { get; set; }
    public Book? Book { get; set; }
}

