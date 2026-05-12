namespace DilmunReadingCoach.Web.Services;

public interface IDashboardService
{
    Task<CoordinatorDashboardViewModel> GetCoordinatorDashboardAsync();
    Task<TeacherDashboardViewModel> GetTeacherDashboardAsync(Guid teacherId);
}

public class CoordinatorDashboardViewModel
{
    public int TotalStudents { get; set; }
    public int ActiveStudents { get; set; }
    public int TotalReadingRecords { get; set; }
    public int TotalReadingMinutes { get; set; }
    public int CurrentTermMinutes { get; set; }
    public Dictionary<string, int> ReadingLevelDistribution { get; set; } = new();
    public List<ClassSummaryViewModel> ClassSummaries { get; set; } = new();
    public List<MissingEntryViewModel> MissingEntries { get; set; } = new();
}

public class TeacherDashboardViewModel
{
    public int TotalStudents { get; set; }
    public int TotalReadingRecords { get; set; }
    public int TotalReadingMinutes { get; set; }
    public List<ClassSummaryViewModel> ClassSummaries { get; set; } = new();
    public List<MissingEntryViewModel> MissingEntries { get; set; } = new();
    public List<StudentLastReadingViewModel> StudentLastReadings { get; set; } = new();
}

public class StudentLastReadingViewModel
{
    public Guid StudentId { get; set; }
    public string StudentName { get; set; } = string.Empty;
    public string ClassName { get; set; } = string.Empty;
    public string LastReadingLevel { get; set; } = string.Empty;
    public DateOnly? LastReadingDate { get; set; }
}

public class ClassSummaryViewModel
{
    public Guid ClassId { get; set; }
    public string ClassName { get; set; } = string.Empty;
    public int StudentCount { get; set; }
    public int RecordCount { get; set; }
    public int TotalMinutes { get; set; }
    public string AverageReadingLevel { get; set; } = string.Empty;
}

public class MissingEntryViewModel
{
    public Guid StudentId { get; set; }
    public string StudentName { get; set; } = string.Empty;
    public string ClassName { get; set; } = string.Empty;
    public DateOnly WeekStart { get; set; }
}

