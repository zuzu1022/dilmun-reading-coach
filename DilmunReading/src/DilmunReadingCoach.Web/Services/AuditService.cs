using DilmunReadingCoach.Core.Entities;
using DilmunReadingCoach.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace DilmunReadingCoach.Web.Services;

public class AuditService : IAuditService
{
    private readonly ApplicationDbContext _context;

    public AuditService(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task LogActionAsync(Guid userId, string actionType, string? entity = null, Guid? entityId = null, string? description = null, string? ipAddress = null)
    {
        var log = new AuditLog
        {
            UserId = userId,
            ActionType = actionType,
            Entity = entity,
            EntityId = entityId,
            Description = description,
            IpAddress = ipAddress,
            CreatedAtUtc = DateTime.UtcNow
        };

        _context.AuditLogs.Add(log);
        await _context.SaveChangesAsync();
    }
}

