using DilmunReadingCoach.Web.Services;
using System.Security.Claims;

namespace DilmunReadingCoach.Web.Middleware;

public class AuditLoggingMiddleware
{
    private readonly RequestDelegate _next;
    private readonly ILogger<AuditLoggingMiddleware> _logger;

    public AuditLoggingMiddleware(RequestDelegate next, ILogger<AuditLoggingMiddleware> logger)
    {
        _next = next;
        _logger = logger;
    }

    public async Task InvokeAsync(HttpContext context, IAuditService auditService)
    {
        if (context.User.Identity?.IsAuthenticated == true)
        {
            var userIdClaim = context.User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (Guid.TryParse(userIdClaim, out var userId))
            {
                var actionType = context.Request.Method switch
                {
                    "POST" when context.Request.Path.Value?.Contains("/login", StringComparison.OrdinalIgnoreCase) == true => "Login",
                    "POST" when context.Request.Path.Value?.Contains("/logout", StringComparison.OrdinalIgnoreCase) == true => "Logout",
                    "POST" => "Create",
                    "PUT" => "Update",
                    "DELETE" => "Delete",
                    _ => null
                };

                if (actionType != null)
                {
                    var ipAddress = context.Connection.RemoteIpAddress?.ToString();
                    var entity = GetEntityFromPath(context.Request.Path.Value);

                    try
                    {
                        // Log synchronously within the request scope to avoid
                        // DbContext concurrency issues from background tasks
                        await auditService.LogActionAsync(
                            userId,
                            actionType,
                            entity,
                            null,
                            $"{actionType} action on {entity}",
                            ipAddress);
                    }
                    catch (Exception ex)
                    {
                        _logger.LogError(ex, "Failed to log audit action");
                    }
                }
            }
        }

        await _next(context);
    }

    private static string? GetEntityFromPath(string? path)
    {
        if (string.IsNullOrEmpty(path)) return null;

        var segments = path.Split('/', StringSplitOptions.RemoveEmptyEntries);
        if (segments.Length > 0)
        {
            var entity = segments[0];
            return entity switch
            {
                "students" => "Student",
                "teachers" => "Teacher",
                "reading" => "ReadingProgress",
                "books" => "Book",
                "classes" => "Classroom",
                "backups" => "Backup",
                _ => null
            };
        }
        return null;
    }
}

