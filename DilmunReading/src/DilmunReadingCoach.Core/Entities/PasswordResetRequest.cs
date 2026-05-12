using System;

namespace DilmunReadingCoach.Core.Entities;

public class PasswordResetRequest : BaseAuditableEntity
{
    public Guid UserId { get; set; }
    public string Status { get; set; } = "Pending";
    public Guid? ApprovedBy { get; set; }
    public DateTime? ApprovedAtUtc { get; set; }
}

