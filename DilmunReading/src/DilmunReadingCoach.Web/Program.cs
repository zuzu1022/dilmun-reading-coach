using System;
using System.Collections.Generic;
using DilmunReadingCoach.Core.Entities;
using DilmunReadingCoach.Infrastructure.Data;
using DilmunReadingCoach.Infrastructure.Identity;
using DilmunReadingCoach.Web.Middleware;
using DilmunReadingCoach.Web.Services;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.CookiePolicy;
using System.Linq;

var builder = WebApplication.CreateBuilder(args);

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection")
    ?? throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");

builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(connectionString));

builder.Services
    .AddIdentity<ApplicationUser, IdentityRole<Guid>>(options =>
    {
        options.SignIn.RequireConfirmedAccount = false;
        options.Lockout.MaxFailedAccessAttempts = 3;
        options.Lockout.DefaultLockoutTimeSpan = TimeSpan.FromMinutes(10);
        options.Password.RequireNonAlphanumeric = false;
        options.Password.RequireUppercase = false;
        options.Password.RequireLowercase = true;
        options.Password.RequireDigit = true;
    })
    .AddEntityFrameworkStores<ApplicationDbContext>()
    .AddDefaultTokenProviders();

builder.Services.ConfigureApplicationCookie(options =>
{
    options.Cookie.HttpOnly = true;
    options.Cookie.SecurePolicy = CookieSecurePolicy.SameAsRequest;
    options.ExpireTimeSpan = TimeSpan.FromMinutes(10);
    options.SlidingExpiration = true;
    options.LoginPath = "/Account/Login";
});

builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(10);
    options.Cookie.HttpOnly = true;
    options.Cookie.SecurePolicy = CookieSecurePolicy.SameAsRequest;
});

// Register services
builder.Services.AddScoped<IAuditService, AuditService>();
builder.Services.AddScoped<IStudentService, StudentService>();
builder.Services.AddScoped<IReadingService, ReadingService>();
builder.Services.AddScoped<IDashboardService, DashboardService>();
builder.Services.AddScoped<IReportService, ReportService>();
builder.Services.AddScoped<IBackupService, BackupService>();
builder.Services.AddScoped<ITeacherService, TeacherService>();

builder.Services.AddControllersWithViews();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseSession();
app.UseAuthentication();
app.UseAuthorization();

// Add audit logging middleware
app.UseMiddleware<AuditLoggingMiddleware>();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Account}/{action=Login}/{id?}");

// Seed database
using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    try
    {
        var context = services.GetRequiredService<ApplicationDbContext>();
        var userManager = services.GetRequiredService<UserManager<ApplicationUser>>();
        var roleManager = services.GetRequiredService<RoleManager<IdentityRole<Guid>>>();
        
        await SeedDataAsync(context, userManager, roleManager);
    }
    catch (Exception ex)
    {
        var logger = services.GetRequiredService<ILogger<Program>>();
        logger.LogError(ex, "An error occurred while seeding the database.");
    }
}

app.Run();

async Task SeedDataAsync(ApplicationDbContext context, UserManager<ApplicationUser> userManager, RoleManager<IdentityRole<Guid>> roleManager)
{
    // Create roles
    if (!await roleManager.RoleExistsAsync("Coordinator"))
    {
        await roleManager.CreateAsync(new IdentityRole<Guid>("Coordinator"));
    }
    
    if (!await roleManager.RoleExistsAsync("Teacher"))
    {
        await roleManager.CreateAsync(new IdentityRole<Guid>("Teacher"));
    }

    // Create default coordinator if doesn't exist
    if (!await userManager.Users.AnyAsync(u => u.Role == "Coordinator"))
    {
        var coordinator = new ApplicationUser
        {
            UserName = "coordinator",
            FirstName = "System",
            LastName = "Coordinator",
            Email = "coordinator@dilmunreading.com",
            Role = "Coordinator",
            IsActive = true,
            EmailConfirmed = true,
            CreatedAtUtc = DateTime.UtcNow
        };

        var result = await userManager.CreateAsync(coordinator, "Coordinator123!");
        if (result.Succeeded)
        {
            await userManager.AddToRoleAsync(coordinator, "Coordinator");
        }
    }

    await SeedSampleDataAsync(context, userManager);
}

async Task SeedSampleDataAsync(ApplicationDbContext context, UserManager<ApplicationUser> userManager)
{
    await EnsureTeacherAccountsAsync();
    await EnsureClassroomsAsync();
    await EnsureBooksAsync();
    await EnsureStudentsAsync();

    var classroomLookup = await context.Classrooms.ToDictionaryAsync(c => c.Name, c => c.Id);
    var studentLookup = await context.Students.ToDictionaryAsync(s => s.StudentCode, s => s.Id);
    var bookLookup = await context.Books.ToDictionaryAsync(b => b.Title, b => b.Id);
    var teacherLookup = await userManager.Users
        .Where(u => u.Role == "Teacher")
        .ToDictionaryAsync(u => u.UserName!, u => u.Id);

    await EnsureTeacherClassesAsync(teacherLookup, classroomLookup);
    await EnsureReadingProgressAsync(teacherLookup, studentLookup, bookLookup);
    await EnsureAuditLogsAsync(teacherLookup, classroomLookup, studentLookup, bookLookup);

    async Task EnsureTeacherAccountsAsync()
    {
        var teacherSeeds = new (string UserName, string First, string Last, string Email, string Phone)[]
        {
            ("teacher.ali", "Ali", "Mansoor", "ali.mansoor@dilmunreading.com", "+97333000001"),
            ("teacher.farah", "Farah", "Al-Qattan", "farah.qattan@dilmunreading.com", "+97333000002"),
            ("teacher.saad", "Saad", "Al-Noaimi", "saad.noaimi@dilmunreading.com", "+97333000003"),
            ("teacher.huda", "Huda", "Al-Khaldi", "huda.khaldi@dilmunreading.com", "+97333000004"),
            ("teacher.malek", "Malek", "Al-Sabah", "malek.sabah@dilmunreading.com", "+97333000005"),
            ("teacher.reem", "Reem", "Al-Ansari", "reem.ansari@dilmunreading.com", "+97333000006"),
            ("teacher.samer", "Samer", "Al-Sharif", "samer.sharif@dilmunreading.com", "+97333000007"),
            ("teacher.lama", "Lama", "Al-Harthy", "lama.harthy@dilmunreading.com", "+97333000008"),
            ("teacher.yousef", "Yousef", "Al-Rifai", "yousef.rifai@dilmunreading.com", "+97333000009"),
            ("teacher.basma", "Basma", "Al-Hassan", "basma.hassan@dilmunreading.com", "+97333000010"),
            ("teacher.karim", "Karim", "Al-Saleh", "karim.saleh@dilmunreading.com", "+97333000011"),
            ("teacher.mona", "Mona", "Al-Tamimi", "mona.tamimi@dilmunreading.com", "+97333000012"),
            ("teacher.sultan", "Sultan", "Al-Zayani", "sultan.zayani@dilmunreading.com", "+97333000013"),
            ("teacher.nour", "Nour", "Al-Darwish", "nour.darwish@dilmunreading.com", "+97333000014"),
            ("teacher.ayman", "Ayman", "Al-Hadid", "ayman.hadid@dilmunreading.com", "+97333000015")
        };

        foreach (var seed in teacherSeeds)
        {
            if (await userManager.FindByNameAsync(seed.UserName) != null)
            {
                continue;
            }

            var teacher = new ApplicationUser
            {
                UserName = seed.UserName,
                FirstName = seed.First,
                LastName = seed.Last,
                Email = seed.Email,
                PhoneNumber = seed.Phone,
                Role = "Teacher",
                IsActive = true,
                EmailConfirmed = true,
                PhoneNumberConfirmed = true,
                CreatedAtUtc = DateTime.UtcNow
            };

            var result = await userManager.CreateAsync(teacher, "Teacher123!");
            if (result.Succeeded)
            {
                await userManager.AddToRoleAsync(teacher, "Teacher");
            }
        }
    }

    async Task EnsureClassroomsAsync()
    {
        if (await context.Classrooms.AnyAsync())
        {
            return;
        }

        var classrooms = new (string Name, string YearGroup)[]
        {
            ("Class 1A", "Grade 1"),
            ("Class 1B", "Grade 1"),
            ("Class 1C", "Grade 1"),
            ("Class 2A", "Grade 2"),
            ("Class 2B", "Grade 2"),
            ("Class 2C", "Grade 2"),
            ("Class 3A", "Grade 3"),
            ("Class 3B", "Grade 3"),
            ("Class 3C", "Grade 3"),
            ("Class 4A", "Grade 4"),
            ("Class 4B", "Grade 4"),
            ("Class 4C", "Grade 4"),
            ("Class 5A", "Grade 5"),
            ("Class 5B", "Grade 5"),
            ("Class 5C", "Grade 5")
        }.Select(c => new Classroom
        {
            Name = c.Name,
            YearGroup = c.YearGroup,
            Status = "Active"
        }).ToList();

        await context.Classrooms.AddRangeAsync(classrooms);
        await context.SaveChangesAsync();
    }

    async Task EnsureBooksAsync()
    {
        var bookData = new (string Title, string Author, string Category, string Level)[]
        {
            ("Tales of the Sea", "Sarah Mitchell", "Short Story", "Level 2"),
            ("The Secret of Lulu's Oasis", "Emily Johnson", "Adventure", "Level 3"),
            ("The Train of Dreams", "Michael Brown", "Inspirational", "Level 1"),
            ("The Planet of Wisdom", "Jennifer Davis", "Educational", "Level 4"),
            ("Islands of Pearls", "David Wilson", "Fantasy", "Level 5"),
            ("The Treasure Box", "Lisa Anderson", "Series", "Level 2"),
            ("Waves of Freedom", "Robert Taylor", "Poetry", "Level 6"),
            ("Paths to the Stars", "Amanda Martinez", "Science", "Level 3"),
            ("The Castle of Seas", "James Thompson", "Adventure", "Level 4"),
            ("Nour's Journey", "Patricia White", "Educational", "Level 1"),
            ("The Art of Reading", "Christopher Lee", "Guide", "Level 5"),
            ("Strings of the Moon", "Michelle Harris", "Fantasy", "Level 6"),
            ("The Desert Book", "Daniel Clark", "Adventure", "Level 2"),
            ("The Lantern of Stories", "Jessica Lewis", "Short Story", "Level 3"),
            ("The Pulse of Words", "Matthew Walker", "Literary", "Level 4")
        };

        // Mapping from old Arabic titles to new English titles
        var titleMapping = new Dictionary<string, string>
        {
            { "Hikayat Al-Bahr", "Tales of the Sea" },
            { "Sirr Wahat Lulu", "The Secret of Lulu's Oasis" },
            { "Qitar Al-Amani", "The Train of Dreams" },
            { "Kawkab Al-Hikma", "The Planet of Wisdom" },
            { "Juzur Al-Marjan", "Islands of Pearls" },
            { "Sunduq Al-Asrar", "The Treasure Box" },
            { "Mawj Al-Hurriyah", "Waves of Freedom" },
            { "Turuq Al-Nujoom", "Paths to the Stars" },
            { "Qasr Al-Buhur", "The Castle of Seas" },
            { "Rihlat Nour", "Nour's Journey" },
            { "Fann Al-Qiraah", "The Art of Reading" },
            { "Awtar Al-Qamar", "Strings of the Moon" },
            { "Kitab Al-Sahra", "The Desert Book" },
            { "Siraj Al-Hikayat", "The Lantern of Stories" },
            { "Nabd Al-Kalimah", "The Pulse of Words" }
        };

        // Update existing books - map Arabic titles to English, or update English books with new author names
        var existingBooks = await context.Books.ToListAsync();
        foreach (var book in existingBooks)
        {
            string targetTitle;
            if (titleMapping.TryGetValue(book.Title, out var mappedTitle))
            {
                targetTitle = mappedTitle;
            }
            else if (bookData.Any(b => b.Title == book.Title))
            {
                // Already has English title, update author and other fields
                targetTitle = book.Title;
            }
            else
            {
                // Book not in our list, skip it
                continue;
            }
            
            var newBookData = bookData.FirstOrDefault(b => b.Title == targetTitle);
            if (!string.IsNullOrEmpty(newBookData.Title))
            {
                book.Title = newBookData.Title;
                book.Author = newBookData.Author;
                book.Category = newBookData.Category;
                book.ReadingLevel = newBookData.Level;
            }
        }

        // Add new books that don't exist
        var existingTitles = existingBooks.Select(b => b.Title).ToHashSet();
        var newBooks = bookData
            .Where(b => !existingTitles.Contains(b.Title))
            .Select(b => new Book
            {
                Title = b.Title,
                Author = b.Author,
                Category = b.Category,
                ReadingLevel = b.Level,
                Status = "Available"
            }).ToList();

        if (newBooks.Any())
        {
            await context.Books.AddRangeAsync(newBooks);
        }

        await context.SaveChangesAsync();
    }

    async Task EnsureStudentsAsync()
    {
        if (await context.Students.AnyAsync())
        {
            return;
        }

        var classroomLookup = await context.Classrooms.ToDictionaryAsync(c => c.Name, c => c.Id);

        var students = new (string Code, string First, string Last, string Gender, DateTime Dob, string Classroom, string Level)[]
        {
            ("ST001", "Ahmad", "Al-Hammadi", "Male", new DateTime(2010, 1, 15), "Class 1A", "Level 2"),
            ("ST002", "Fatimah", "Al-Khalifa", "Female", new DateTime(2010, 3, 22), "Class 1A", "Level 1"),
            ("ST003", "Mohammed", "Al-Hajri", "Male", new DateTime(2009, 11, 8), "Class 1B", "Level 3"),
            ("ST004", "Sara", "Al-Mousa", "Female", new DateTime(2010, 5, 14), "Class 1B", "Level 2"),
            ("ST005", "Ali", "Al-Hasan", "Male", new DateTime(2009, 9, 30), "Class 2A", "Level 4"),
            ("ST006", "Noura", "Al-Subaie", "Female", new DateTime(2009, 7, 18), "Class 2A", "Level 3"),
            ("ST007", "Hamad", "Al-Kaabi", "Male", new DateTime(2009, 12, 5), "Class 2B", "Level 5"),
            ("ST008", "Maryam", "Al-Awadi", "Female", new DateTime(2009, 4, 20), "Class 2B", "Level 4"),
            ("ST009", "Omar", "Al-Khayyat", "Male", new DateTime(2008, 10, 12), "Class 3A", "Level 6"),
            ("ST010", "Layla", "Abdullah", "Female", new DateTime(2008, 8, 25), "Class 3A", "Level 5"),
            ("ST011", "Yassin", "Al-Saffar", "Male", new DateTime(2008, 3, 11), "Class 3B", "Level 4"),
            ("ST012", "Hiba", "Al-Jabri", "Female", new DateTime(2008, 6, 27), "Class 3C", "Level 4"),
            ("ST013", "Sami", "Al-Qattan", "Male", new DateTime(2007, 12, 19), "Class 4A", "Level 5"),
            ("ST014", "Dana", "Al-Naimi", "Female", new DateTime(2007, 10, 7), "Class 5A", "Level 6"),
            ("ST015", "Rakan", "Al-Mutlaq", "Male", new DateTime(2007, 5, 2), "Class 5B", "Level 6")
        }.Select(s => new Student
        {
            StudentCode = s.Code,
            FirstName = s.First,
            LastName = s.Last,
            Gender = s.Gender,
            DateOfBirth = s.Dob,
            ClassroomId = classroomLookup[s.Classroom],
            ReadingLevel = s.Level,
            Status = "Active"
        }).ToList();

        await context.Students.AddRangeAsync(students);
        await context.SaveChangesAsync();
    }

    async Task EnsureTeacherClassesAsync(IReadOnlyDictionary<string, Guid> teachers, IReadOnlyDictionary<string, Guid> classrooms)
    {
        if (await context.TeacherClasses.AnyAsync() || teachers.Count == 0 || classrooms.Count == 0)
        {
            return;
        }

        var assignments = new Dictionary<string, string[]>
        {
            ["teacher.ali"] = new[] { "Class 1A", "Class 1B" },
            ["teacher.farah"] = new[] { "Class 1C", "Class 2A" },
            ["teacher.saad"] = new[] { "Class 2B", "Class 2C" },
            ["teacher.huda"] = new[] { "Class 3A" },
            ["teacher.malek"] = new[] { "Class 3B", "Class 3C" },
            ["teacher.reem"] = new[] { "Class 4A" },
            ["teacher.samer"] = new[] { "Class 4B" },
            ["teacher.lama"] = new[] { "Class 4C" },
            ["teacher.yousef"] = new[] { "Class 5A" },
            ["teacher.basma"] = new[] { "Class 5B" },
            ["teacher.karim"] = new[] { "Class 5C" },
            ["teacher.mona"] = new[] { "Class 2A" },
            ["teacher.sultan"] = new[] { "Class 3A" },
            ["teacher.nour"] = new[] { "Class 1C" },
            ["teacher.ayman"] = new[] { "Class 4A" }
        };

        var teacherClasses = new List<TeacherClass>();

        foreach (var assignment in assignments)
        {
            if (!teachers.TryGetValue(assignment.Key, out var teacherId))
            {
                continue;
            }

            foreach (var className in assignment.Value.Distinct())
            {
                if (!classrooms.TryGetValue(className, out var classroomId))
                {
                    continue;
                }

                teacherClasses.Add(new TeacherClass
                {
                    TeacherId = teacherId,
                    ClassroomId = classroomId
                });
            }
        }

        if (teacherClasses.Any())
        {
            await context.TeacherClasses.AddRangeAsync(teacherClasses);
            await context.SaveChangesAsync();
        }
    }

    async Task EnsureReadingProgressAsync(
        IReadOnlyDictionary<string, Guid> teachers,
        IReadOnlyDictionary<string, Guid> students,
        IReadOnlyDictionary<string, Guid> books)
    {
        if (await context.ReadingProgress.AnyAsync() || teachers.Count == 0 || students.Count == 0)
        {
            return;
        }

        var readingSeeds = new (string StudentCode, string TeacherUser, string? BookTitle, DateOnly WeekStart, string Level, int Minutes, string Notes)[]
        {
            ("ST001", "teacher.ali", "Tales of the Sea", new DateOnly(2024, 9, 2), "Level 2", 45, "Strong fluency"),
            ("ST002", "teacher.ali", "The Train of Dreams", new DateOnly(2024, 9, 2), "Level 1", 30, "Needs vowel practice"),
            ("ST003", "teacher.farah", "The Secret of Lulu's Oasis", new DateOnly(2024, 9, 9), "Level 3", 50, "Excellent comprehension"),
            ("ST004", "teacher.farah", "The Planet of Wisdom", new DateOnly(2024, 9, 9), "Level 2", 35, "Improving pacing"),
            ("ST005", "teacher.saad", "Islands of Pearls", new DateOnly(2024, 9, 16), "Level 4", 60, "Confident narrator"),
            ("ST006", "teacher.saad", "The Treasure Box", new DateOnly(2024, 9, 16), "Level 3", 40, "Great focus"),
            ("ST007", "teacher.huda", "Waves of Freedom", new DateOnly(2024, 9, 23), "Level 5", 55, "Powerful expression"),
            ("ST008", "teacher.huda", "Paths to the Stars", new DateOnly(2024, 9, 23), "Level 4", 45, "Solid vocabulary"),
            ("ST009", "teacher.malek", "The Castle of Seas", new DateOnly(2024, 9, 30), "Level 6", 70, "Leadership in group reading"),
            ("ST010", "teacher.malek", "Nour's Journey", new DateOnly(2024, 9, 30), "Level 5", 50, "Great summarizing"),
            ("ST011", "teacher.reem", "The Art of Reading", new DateOnly(2024, 10, 7), "Level 4", 40, "Working on tone"),
            ("ST012", "teacher.reem", "Strings of the Moon", new DateOnly(2024, 10, 7), "Level 4", 55, "Detailed observations"),
            ("ST013", "teacher.samer", "The Desert Book", new DateOnly(2024, 10, 14), "Level 5", 65, "Engages classmates"),
            ("ST014", "teacher.lama", "The Lantern of Stories", new DateOnly(2024, 10, 14), "Level 6", 60, "Smooth storyteller"),
            ("ST015", "teacher.yousef", "The Pulse of Words", new DateOnly(2024, 10, 21), "Level 6", 50, "Great critical thinking")
        };

        var entries = new List<ReadingProgress>();

        foreach (var seed in readingSeeds)
        {
            if (!students.TryGetValue(seed.StudentCode, out var studentId) ||
                !teachers.TryGetValue(seed.TeacherUser, out var teacherId))
            {
                continue;
            }

            Guid? bookId = null;
            if (!string.IsNullOrWhiteSpace(seed.BookTitle) && books.TryGetValue(seed.BookTitle, out var bId))
            {
                bookId = bId;
            }

            entries.Add(new ReadingProgress
            {
                StudentId = studentId,
                TeacherId = teacherId,
                BookId = bookId,
                WeekStartDate = seed.WeekStart,
                ReadingLevel = seed.Level,
                DurationMinutes = seed.Minutes,
                Notes = seed.Notes
            });
        }

        if (entries.Any())
        {
            await context.ReadingProgress.AddRangeAsync(entries);
            await context.SaveChangesAsync();
        }
    }

    async Task EnsureAuditLogsAsync(
        IReadOnlyDictionary<string, Guid> teachers,
        IReadOnlyDictionary<string, Guid> classrooms,
        IReadOnlyDictionary<string, Guid> students,
        IReadOnlyDictionary<string, Guid> books)
    {
        if (await context.AuditLogs.AnyAsync())
        {
            return;
        }

        var coordinator = await userManager.FindByNameAsync("coordinator");

        var auditSeeds = new (string User, string Action, string? Entity, string? EntityRef, string Description, int DaysOffset)[]
        {
            ("coordinator", "Login", "System", null, "Coordinator login", -12),
            ("coordinator", "Create", "Classroom", "Class 1C", "Created Class 1C", -11),
            ("teacher.ali", "Login", "System", null, "Teacher Ali login", -10),
            ("teacher.ali", "Create", "Student", "ST001", "Logged reading session for Ahmad", -10),
            ("teacher.farah", "Update", "Student", "ST004", "Updated Sara profile", -9),
            ("teacher.saad", "Create", "Student", "ST006", "Recorded Noura practice", -9),
            ("teacher.huda", "Create", "Student", "ST007", "Documented Hamad progress", -8),
            ("teacher.malek", "Create", "Student", "ST009", "Submitted Omar weekly report", -7),
            ("teacher.reem", "Update", "Classroom", "Class 4B", "Adjusted Class 4B plan", -7),
            ("teacher.samer", "Create", "Student", "ST013", "Added Sami progress", -6),
            ("teacher.lama", "Create", "Student", "ST014", "Captured Dana reading", -6),
            ("teacher.yousef", "Create", "Student", "ST015", "Recorded Rakan session", -5),
            ("teacher.basma", "Create", "Book", "Fann Al-Qiraah", "Suggested new resource", -4),
            ("teacher.karim", "Delete", "Student", "ST002", "Removed duplicate entry", -3),
            ("teacher.nour", "Login", "System", null, "Teacher Nour login", -2)
        };

        var logs = new List<AuditLog>();

        foreach (var seed in auditSeeds)
        {
            Guid? userId = null;
            if (seed.User == "coordinator" && coordinator != null)
            {
                userId = coordinator.Id;
            }
            else if (teachers.TryGetValue(seed.User, out var teacherId))
            {
                userId = teacherId;
            }

            if (userId == null)
            {
                continue;
            }

            Guid? entityId = seed.Entity switch
            {
                "Classroom" when seed.EntityRef != null && classrooms.TryGetValue(seed.EntityRef, out var classId) => classId,
                "Student" when seed.EntityRef != null && students.TryGetValue(seed.EntityRef, out var studentId) => studentId,
                "Book" when seed.EntityRef != null && books.TryGetValue(seed.EntityRef, out var bookId) => bookId,
                _ => null
            };

            logs.Add(new AuditLog
            {
                UserId = userId.Value,
                ActionType = seed.Action,
                Entity = seed.Entity,
                EntityId = entityId,
                Description = seed.Description,
                IpAddress = "192.168.1.20",
                CreatedAtUtc = DateTime.UtcNow.AddDays(seed.DaysOffset)
            });
        }

        if (logs.Any())
        {
            await context.AuditLogs.AddRangeAsync(logs);
            await context.SaveChangesAsync();
        }
    }
}
