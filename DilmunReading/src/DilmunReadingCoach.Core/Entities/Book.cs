namespace DilmunReadingCoach.Core.Entities;

public class Book : BaseAuditableEntity
{
    public string Title { get; set; } = string.Empty;
    public string Author { get; set; } = string.Empty;
    public string Category { get; set; } = string.Empty;
    public string ReadingLevel { get; set; } = string.Empty;
    public string Status { get; set; } = "Available";
}

