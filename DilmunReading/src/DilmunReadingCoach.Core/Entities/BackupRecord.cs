using System;

namespace DilmunReadingCoach.Core.Entities;

public class BackupRecord : BaseAuditableEntity
{
    public string FileName { get; set; } = string.Empty;
    public DateTime StartedAtUtc { get; set; }
    public DateTime? CompletedAtUtc { get; set; }
    public string Type { get; set; } = "Automatic";
    public string Status { get; set; } = "InProgress";
    public Guid? TriggeredBy { get; set; }
    public string? Notes { get; set; }
}

