using DilmunReadingCoach.Core.Entities;

namespace DilmunReadingCoach.Web.Services;

public interface IBackupService
{
    Task<BackupRecord> CreateBackupAsync(Guid? triggeredBy);
    Task<List<BackupRecord>> GetBackupHistoryAsync();
    Task<BackupRecord?> GetBackupByIdAsync(Guid id);
    Task<bool> RestoreBackupAsync(Guid backupId);
}

