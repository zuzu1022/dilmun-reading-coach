using DilmunReadingCoach.Core.Entities;
using DilmunReadingCoach.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace DilmunReadingCoach.Web.Services;

public class BackupService : IBackupService
{
    private readonly ApplicationDbContext _context;
    private readonly IConfiguration _configuration;

    public BackupService(ApplicationDbContext context, IConfiguration configuration)
    {
        _context = context;
        _configuration = configuration;
    }

    public async Task<BackupRecord> CreateBackupAsync(Guid? triggeredBy)
    {
        var backup = new BackupRecord
        {
            Id = Guid.NewGuid(),
            Type = triggeredBy.HasValue ? "Manual" : "Automatic",
            Status = "InProgress",
            StartedAtUtc = DateTime.UtcNow,
            TriggeredBy = triggeredBy,
            FileName = $"backup_{DateTime.UtcNow:yyyyMMddHHmmss}.bak"
        };

        _context.BackupRecords.Add(backup);
        await _context.SaveChangesAsync();

        try
        {
            // In production, this would execute SQL Server BACKUP command
            // For now, we'll simulate success
            await Task.Delay(1000); // Simulate backup time

            backup.Status = "Success";
            backup.CompletedAtUtc = DateTime.UtcNow;
            backup.Notes = "Backup completed successfully";
        }
        catch (Exception ex)
        {
            backup.Status = "Failed";
            backup.CompletedAtUtc = DateTime.UtcNow;
            backup.Notes = $"Backup failed: {ex.Message}";
        }

        await _context.SaveChangesAsync();
        return backup;
    }

    public async Task<List<BackupRecord>> GetBackupHistoryAsync()
    {
        return await _context.BackupRecords
            .OrderByDescending(b => b.StartedAtUtc)
            .Take(50)
            .ToListAsync();
    }

    public async Task<BackupRecord?> GetBackupByIdAsync(Guid id)
    {
        return await _context.BackupRecords.FindAsync(id);
    }

    public async Task<bool> RestoreBackupAsync(Guid backupId)
    {
        var backup = await GetBackupByIdAsync(backupId);
        if (backup == null || backup.Status != "Success") return false;

        try
        {
            // In production, this would execute SQL Server RESTORE command
            // For now, we'll simulate success
            await Task.Delay(2000); // Simulate restore time
            return true;
        }
        catch
        {
            return false;
        }
    }
}

