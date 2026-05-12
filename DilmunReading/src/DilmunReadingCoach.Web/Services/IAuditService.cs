using DilmunReadingCoach.Core.Entities;

namespace DilmunReadingCoach.Web.Services;

public interface IAuditService
{
    Task LogActionAsync(Guid userId, string actionType, string? entity = null, Guid? entityId = null, string? description = null, string? ipAddress = null);
}

