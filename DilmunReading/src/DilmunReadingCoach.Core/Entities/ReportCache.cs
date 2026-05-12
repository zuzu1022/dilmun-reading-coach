using System;

namespace DilmunReadingCoach.Core.Entities;

public class ReportCache : BaseAuditableEntity
{
    public string ReportType { get; set; } = string.Empty;
    public Guid? ScopeId { get; set; }
    public DateOnly PeriodStart { get; set; }
    public DateOnly PeriodEnd { get; set; }
    public string PayloadJson { get; set; } = string.Empty;
}

