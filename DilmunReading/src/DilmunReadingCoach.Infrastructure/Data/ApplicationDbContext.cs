using System;
using DilmunReadingCoach.Core.Entities;
using DilmunReadingCoach.Infrastructure.Identity;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace DilmunReadingCoach.Infrastructure.Data;

public class ApplicationDbContext : IdentityDbContext<ApplicationUser, IdentityRole<Guid>, Guid>
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
    {
    }

    public DbSet<Classroom> Classrooms => Set<Classroom>();
    public DbSet<Student> Students => Set<Student>();
    public DbSet<Book> Books => Set<Book>();
    public DbSet<ReadingProgress> ReadingProgress => Set<ReadingProgress>();
    public DbSet<TeacherClass> TeacherClasses => Set<TeacherClass>();
    public DbSet<ReportCache> ReportCaches => Set<ReportCache>();
    public DbSet<PasswordResetRequest> PasswordResetRequests => Set<PasswordResetRequest>();
    public DbSet<BackupRecord> BackupRecords => Set<BackupRecord>();
    public DbSet<AuditLog> AuditLogs => Set<AuditLog>();
    public DbSet<SystemSetting> SystemSettings => Set<SystemSetting>();

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);

        builder.Entity<ApplicationUser>(entity =>
        {
            entity.ToTable("Users");
            entity.Property(x => x.FirstName).HasMaxLength(100);
            entity.Property(x => x.LastName).HasMaxLength(100);
            entity.Property(x => x.Role).HasMaxLength(20);
            entity.HasIndex(x => x.UserName).IsUnique();
            entity.Ignore(x => x.LastLoginAt); // This is handled by Identity
        });

        builder.Entity<IdentityRole<Guid>>(entity =>
        {
            entity.ToTable("Roles");
        });

        builder.Entity<IdentityUserRole<Guid>>(entity =>
        {
            entity.ToTable("UserRoles");
        });

        builder.Entity<IdentityUserClaim<Guid>>(entity =>
        {
            entity.ToTable("UserClaims");
        });

        builder.Entity<IdentityUserLogin<Guid>>(entity =>
        {
            entity.ToTable("UserLogins");
        });

        builder.Entity<IdentityRoleClaim<Guid>>(entity =>
        {
            entity.ToTable("RoleClaims");
        });

        builder.Entity<IdentityUserToken<Guid>>(entity =>
        {
            entity.ToTable("UserTokens");
        });

        builder.Entity<Classroom>(entity =>
        {
            entity.Property(x => x.Name).HasMaxLength(100);
            entity.HasIndex(x => x.Name).IsUnique();
        });

        builder.Entity<Student>(entity =>
        {
            entity.Property(x => x.StudentCode).HasMaxLength(50);
            entity.HasIndex(x => x.StudentCode).IsUnique();
            entity.HasIndex(x => new { x.ClassroomId, x.Status });
        });

        builder.Entity<Book>(entity =>
        {
            entity.Property(x => x.Title).HasMaxLength(200);
            entity.Property(x => x.Author).HasMaxLength(150);
            entity.HasIndex(x => new { x.Title, x.Author }).IsUnique();
        });

        var dateOnlyConverter = new ValueConverter<DateOnly, DateTime>(
            v => v.ToDateTime(TimeOnly.MinValue, DateTimeKind.Utc),
            v => DateOnly.FromDateTime(DateTime.SpecifyKind(v, DateTimeKind.Utc)));

        builder.Entity<ReadingProgress>(entity =>
        {
            entity.HasIndex(x => new { x.StudentId, x.WeekStartDate }).IsUnique();
            entity.Property(x => x.DurationMinutes).HasDefaultValue(0);
            entity.Property(x => x.WeekStartDate)
                .HasConversion(dateOnlyConverter)
                .HasColumnType("date");
        });

        builder.Entity<TeacherClass>(entity =>
        {
            entity.HasKey(x => new { x.TeacherId, x.ClassroomId });
            entity.HasOne(x => x.Classroom)
                .WithMany()
                .HasForeignKey(x => x.ClassroomId);
        });

        builder.Entity<ReportCache>(entity =>
        {
            entity.HasIndex(x => new { x.ReportType, x.ScopeId, x.PeriodStart, x.PeriodEnd });
            entity.Property(x => x.PeriodStart)
                .HasConversion(dateOnlyConverter)
                .HasColumnType("date");
            entity.Property(x => x.PeriodEnd)
                .HasConversion(dateOnlyConverter)
                .HasColumnType("date");
        });

        builder.Entity<SystemSetting>(entity =>
        {
            entity.HasKey(x => x.Key);
        });
    }
}

