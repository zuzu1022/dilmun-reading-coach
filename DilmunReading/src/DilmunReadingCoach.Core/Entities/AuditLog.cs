using System;

namespace DilmunReadingCoach.Core.Entities;

public class AuditLog
{
    public long Id { get; set; }
    public Guid UserId { get; set; }
    public string ActionType { get; set; } = string.Empty;
    public string? Entity { get; set; }
    public Guid? EntityId { get; set; }
    public string? Description { get; set; }
    public string? IpAddress { get; set; }
    public DateTime CreatedAtUtc { get; set; } = DateTime.UtcNow;
}

