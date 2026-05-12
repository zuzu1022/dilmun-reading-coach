# Dilmun Reading Coach - Technical Documentation

## Table of Contents
1. [System Overview](#system-overview)
2. [Architecture](#architecture)
3. [Project Structure](#project-structure)
4. [Database Schema](#database-schema)
5. [Key Components](#key-components)
6. [Data Flow](#data-flow)
7. [Authentication & Authorization](#authentication--authorization)
8. [Services Layer](#services-layer)
9. [Controllers](#controllers)
10. [Middleware](#middleware)
11. [Deployment](#deployment)
12. [Configuration](#configuration)

---

## System Overview

**Dilmun Reading Coach** is an ASP.NET Core 8.0 web application designed to manage reading progress tracking for students in a school environment. The system supports two main user roles: **Coordinators** (administrators) and **Teachers**.

### Key Features
- Student management and reading progress tracking
- Book catalog management
- Classroom organization
- Weekly and term-based reporting
- Audit logging for all system actions
- Backup and restore functionality
- Password reset request management

### Technology Stack
- **Framework**: ASP.NET Core 8.0 (MVC)
- **Database**: SQL Server (Remote: db33679.public.databaseasp.net)
- **ORM**: Entity Framework Core 8.0
- **Authentication**: ASP.NET Core Identity
- **Frontend**: Razor Views, Bootstrap 5, jQuery
- **PDF Generation**: QuestPDF

---

## Architecture

The application follows a **Clean Architecture** pattern with three main layers:

```
┌─────────────────────────────────────┐
│     DilmunReadingCoach.Web          │  ← Presentation Layer
│  (Controllers, Views, Middleware)   │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│  DilmunReadingCoach.Infrastructure   │  ← Data Access Layer
│  (DbContext, Identity, Migrations)    │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│     DilmunReadingCoach.Core          │  ← Domain Layer
│      (Entities, Business Logic)     │
└──────────────────────────────────────┘
```

### Layer Responsibilities

1. **Core Layer** (`DilmunReadingCoach.Core`)
   - Domain entities (Student, Book, Classroom, etc.)
   - Business logic interfaces
   - No dependencies on other layers

2. **Infrastructure Layer** (`DilmunReadingCoach.Infrastructure`)
   - Database context and Entity Framework configuration
   - Identity implementation
   - Data access implementations

3. **Web Layer** (`DilmunReadingCoach.Web`)
   - Controllers (MVC)
   - Views (Razor)
   - Services implementation
   - Middleware
   - Configuration

---

## Project Structure

```
DilmunWebsite/
├── src/
│   ├── DilmunReadingCoach.Core/
│   │   ├── Entities/              # Domain entities
│   │   │   ├── Student.cs
│   │   │   ├── Book.cs
│   │   │   ├── Classroom.cs
│   │   │   ├── ReadingProgress.cs
│   │   │   ├── TeacherClass.cs
│   │   │   ├── AuditLog.cs
│   │   │   ├── BackupRecord.cs
│   │   │   ├── PasswordResetRequest.cs
│   │   │   ├── ReportCache.cs
│   │   │   ├── SystemSetting.cs
│   │   │   └── BaseAuditableEntity.cs
│   │   └── DilmunReadingCoach.Core.csproj
│   │
│   ├── DilmunReadingCoach.Infrastructure/
│   │   ├── Data/
│   │   │   ├── ApplicationDbContext.cs    # EF Core DbContext
│   │   │   └── Migrations/                # Database migrations
│   │   ├── Identity/
│   │   │   └── ApplicationUser.cs         # Custom user entity
│   │   └── DilmunReadingCoach.Infrastructure.csproj
│   │
│   └── DilmunReadingCoach.Web/
│       ├── Controllers/            # MVC Controllers
│       ├── Views/                  # Razor views
│       ├── Services/               # Business logic services
│       ├── Middleware/             # Custom middleware
│       ├── Models/                  # View models
│       ├── wwwroot/                # Static files (CSS, JS, images)
│       ├── Program.cs              # Application entry point
│       └── appsettings.json         # Configuration
│
└── docs/
    └── TECHNICAL_DOCUMENTATION.md
```

---

## Database Schema

### Connection String
```
Server=db33679.public.databaseasp.net
Database=db33679
User Id=db33679
Password=Nz5?6%rKGc7!
Encrypt=True
TrustServerCertificate=True
MultipleActiveResultSets=True
```

### Core Tables

#### 1. **Users** (ASP.NET Identity)
- `Id` (Guid, PK)
- `UserName`, `NormalizedUserName`
- `Email`, `NormalizedEmail`
- `PasswordHash`
- `FirstName`, `LastName`
- `Role` (Coordinator/Teacher)
- `IsActive`
- `CreatedAtUtc`, `UpdatedAtUtc`

#### 2. **Roles** (ASP.NET Identity)
- `Id` (Guid, PK)
- `Name`, `NormalizedName`
- Roles: "Coordinator", "Teacher"

#### 3. **Classrooms**
- `Id` (Guid, PK)
- `Name` (Unique, MaxLength: 100)
- `YearGroup` (e.g., "Grade 1")
- `Status` (Active/Inactive)
- `CreatedAtUtc`, `UpdatedAtUtc`

#### 4. **Students**
- `Id` (Guid, PK)
- `StudentCode` (Unique, MaxLength: 50)
- `FirstName`, `LastName`
- `Gender`
- `DateOfBirth`
- `ClassroomId` (FK → Classrooms)
- `ReadingLevel` (Level 1-6)
- `Status` (Active/Inactive)
- `CreatedAtUtc`, `UpdatedAtUtc`
- **Indexes**: `IX_Students_StudentCode`, `IX_Students_ClassroomId_Status`

#### 5. **Books**
- `Id` (Guid, PK)
- `Title` (MaxLength: 200)
- `Author` (MaxLength: 150)
- `Category` (Short Story, Adventure, Educational, etc.)
- `ReadingLevel` (Level 1-6)
- `Status` (Available/Unavailable)
- `CreatedAtUtc`, `UpdatedAtUtc`
- **Index**: `IX_Books_Title_Author` (Unique)

#### 6. **ReadingProgress**
- `Id` (Guid, PK)
- `StudentId` (FK → Students, CASCADE DELETE)
- `TeacherId` (FK → Users)
- `BookId` (FK → Books, nullable)
- `WeekStartDate` (Date, Unique per Student)
- `ReadingLevel`
- `DurationMinutes` (Default: 0)
- `Notes`
- `CreatedAtUtc`, `UpdatedAtUtc`
- **Index**: `IX_ReadingProgress_StudentId_WeekStartDate` (Unique)

#### 7. **TeacherClasses** (Many-to-Many)
- `TeacherId` (FK → Users)
- `ClassroomId` (FK → Classrooms, CASCADE DELETE)
- **Composite PK**: (TeacherId, ClassroomId)

#### 8. **AuditLogs**
- `Id` (BigInt, PK, Identity)
- `UserId` (FK → Users)
- `ActionType` (Login, Logout, Create, Update, Delete)
- `Entity` (Student, Book, Classroom, etc.)
- `EntityId` (Guid, nullable)
- `Description`
- `IpAddress`
- `CreatedAtUtc`

#### 9. **BackupRecords**
- `Id` (Guid, PK)
- `FileName`
- `StartedAtUtc`, `CompletedAtUtc`
- `Type` (Full, Partial)
- `Status` (InProgress, Completed, Failed)
- `TriggeredBy` (FK → Users, nullable)
- `Notes`
- `CreatedAtUtc`, `UpdatedAtUtc`

#### 10. **PasswordResetRequests**
- `Id` (Guid, PK)
- `UserId` (FK → Users)
- `Status` (Pending, Approved, Rejected)
- `ApprovedBy` (FK → Users, nullable)
- `ApprovedAtUtc` (nullable)
- `CreatedAtUtc`, `UpdatedAtUtc`

#### 11. **ReportCaches**
- `Id` (Guid, PK)
- `ReportType` (Dashboard, Weekly, Term)
- `ScopeId` (Guid, nullable - TeacherId or null for Coordinator)
- `PeriodStart` (Date)
- `PeriodEnd` (Date)
- `PayloadJson` (Serialized report data)
- `CreatedAtUtc`, `UpdatedAtUtc`
- **Index**: `IX_ReportCaches_ReportType_ScopeId_PeriodStart_PeriodEnd`

#### 12. **SystemSettings**
- `Key` (String, PK)
- `Value` (String)
- `UpdatedAtUtc`

### Relationships

```
Users (Teachers) ←─── TeacherClasses ───→ Classrooms
                              │
                              ↓
                          Students
                              │
                              ↓
                      ReadingProgress
                              │
                              ├──→ Books
                              └──→ Users (Teachers)
```

---

## Key Components

### 1. **ApplicationDbContext** (`Infrastructure/Data/ApplicationDbContext.cs`)
- Inherits from `IdentityDbContext<ApplicationUser, IdentityRole<Guid>, Guid>`
- Configures all entity relationships, indexes, and constraints
- Handles DateOnly conversion for SQL Server date columns
- Custom table names for Identity tables

### 2. **ApplicationUser** (`Infrastructure/Identity/ApplicationUser.cs`)
- Extends `IdentityUser<Guid>`
- Additional properties: `FirstName`, `LastName`, `Role`, `IsActive`
- Custom role-based authentication

### 3. **BaseAuditableEntity** (`Core/Entities/BaseAuditableEntity.cs`)
- Base class for entities requiring audit fields
- Properties: `Id` (Guid), `CreatedAtUtc`, `UpdatedAtUtc`
- Inherited by: Student, Book, Classroom, ReadingProgress, etc.

---

## Data Flow

### User Login Flow
```
1. User submits login form (Account/Login)
   ↓
2. AccountController.Login() validates credentials
   ↓
3. SignInManager.PasswordSignInAsync() authenticates
   ↓
4. AuditLoggingMiddleware logs the login action
   ↓
5. AuditService.LogActionAsync() saves to AuditLogs table
   ↓
6. User redirected to Dashboard (Coordinator or Teacher view)
```

### Reading Progress Entry Flow
```
1. Teacher navigates to Reading/Index
   ↓
2. ReadingController.Index() displays students in teacher's classes
   ↓
3. Teacher submits reading entry form
   ↓
4. ReadingController.Create() receives POST request
   ↓
5. ReadingService.CreateReadingEntryAsync() validates and saves
   ↓
6. AuditLoggingMiddleware logs "Create" action
   ↓
7. ReadingProgress record saved to database
   ↓
8. Teacher redirected to Reading/Index with success message
```

### Report Generation Flow
```
1. User requests report (Reports/Weekly or Reports/Term)
   ↓
2. ReportsController checks ReportCache for existing report
   ↓
3. If cached and fresh → return cached data
   ↓
4. If not cached or stale → ReportService.GenerateWeeklyReport()
   ↓
5. Service queries ReadingProgress, Students, Books
   ↓
6. Aggregates data (total minutes, students read, books read)
   ↓
7. Serializes to JSON and saves to ReportCache
   ↓
8. Returns report data to view
```

---

## Authentication & Authorization

### Authentication
- **Method**: ASP.NET Core Identity with cookie-based authentication
- **Session Timeout**: 10 minutes (sliding expiration)
- **Lockout Policy**: 3 failed attempts → 10 minute lockout
- **Password Requirements**:
  - Minimum 1 lowercase letter
  - Minimum 1 digit
  - No uppercase or special character requirement

### Authorization
- **Role-Based Access Control (RBAC)**
  - **Coordinator Role**: Full system access
    - Manage students, teachers, classrooms, books
    - View all reports
    - Access audit logs and backups
    - Approve password reset requests
  - **Teacher Role**: Limited access
    - View assigned classrooms and students
    - Create/update reading progress entries
    - View own dashboard and reports
    - Request password resets

### Authorization Attributes
```csharp
[Authorize]                    // Requires authentication
[Authorize(Roles = "Coordinator")]  // Requires Coordinator role
[AllowAnonymous]               // Public access (login page)
```

---

## Services Layer

All services are registered as **Scoped** in `Program.cs`:

### 1. **IAuditService / AuditService**
- **Purpose**: Log all system actions
- **Methods**:
  - `LogActionAsync()` - Creates audit log entries
- **Used by**: Controllers, Middleware

### 2. **IStudentService / StudentService**
- **Purpose**: Student management operations
- **Methods**:
  - `GetStudentsByClassroomAsync()` - Get students in a classroom
  - `GetStudentByIdAsync()` - Get student details
  - `CreateStudentAsync()` - Add new student
  - `UpdateStudentAsync()` - Update student information
  - `DeleteStudentAsync()` - Soft delete student

### 3. **IReadingService / ReadingService**
- **Purpose**: Reading progress tracking
- **Methods**:
  - `GetReadingEntriesAsync()` - Get reading progress for students
  - `CreateReadingEntryAsync()` - Create new reading session
  - `UpdateReadingEntryAsync()` - Update existing entry
  - `GetStudentReadingHistoryAsync()` - Get student's reading history

### 4. **IDashboardService / DashboardService**
- **Purpose**: Dashboard data aggregation
- **Methods**:
  - `GetCoordinatorDashboardAsync()` - Coordinator dashboard stats
  - `GetTeacherDashboardAsync()` - Teacher dashboard stats
- **Caching**: Uses ReportCache for performance

### 5. **IReportService / ReportService**
- **Purpose**: Report generation and caching
- **Methods**:
  - `GenerateWeeklyReportAsync()` - Generate weekly reading report
  - `GenerateTermReportAsync()` - Generate term-based report
  - `GetCachedReportAsync()` - Retrieve cached report
- **Caching Strategy**: Reports cached for 1 hour

### 6. **IBackupService / BackupService**
- **Purpose**: Database backup management
- **Methods**:
  - `CreateBackupAsync()` - Create database backup
  - `GetBackupRecordsAsync()` - List all backups
  - `DownloadBackupAsync()` - Download backup file

### 7. **ITeacherService / TeacherService**
- **Purpose**: Teacher account management
- **Methods**:
  - `GetTeachersAsync()` - List all teachers
  - `GetTeacherByIdAsync()` - Get teacher details
  - `CreateTeacherAsync()` - Create new teacher account
  - `UpdateTeacherAsync()` - Update teacher information
  - `GetTeacherClassroomsAsync()` - Get classrooms assigned to teacher

---

## Controllers

### AccountController
- **Login** (GET/POST) - User authentication
- **Logout** (POST) - User sign out
- **KeepAlive** (POST) - Extend session timeout

### DashboardController
- **Coordinator** (GET) - Coordinator dashboard view
- **Teacher** (GET) - Teacher dashboard view

### StudentsController
- **Index** (GET) - List students (filtered by role)
- **Details** (GET) - Student details view
- **Create** (GET/POST) - Add new student
- **Edit** (GET/POST) - Update student
- **Delete** (GET/POST) - Delete student

### ReadingController
- **Index** (GET) - List reading entries
- **Create** (GET/POST) - Create reading progress entry
- **Edit** (GET/POST) - Update reading entry
- **Delete** (GET/POST) - Delete reading entry

### BooksController
- **Index** (GET) - List books
- **Create** (GET/POST) - Add new book
- **Edit** (GET/POST) - Update book
- **Delete** (GET/POST) - Delete book

### ClassesController
- **Index** (GET) - List classrooms
- **Create** (GET/POST) - Add new classroom
- **Edit** (GET/POST) - Update classroom
- **Delete** (GET/POST) - Delete classroom

### TeachersController
- **Index** (GET) - List teachers
- **Create** (GET/POST) - Add new teacher
- **Edit** (GET/POST) - Update teacher
- **Delete** (GET/POST) - Delete teacher

### ReportsController
- **Weekly** (GET) - Weekly reading report
- **Term** (GET) - Term-based report

### AuditLogsController
- **Index** (GET) - List audit logs (Coordinator only)
- **Details** (GET) - Audit log details

### BackupsController
- **Index** (GET) - List backup records (Coordinator only)
- **Create** (POST) - Create new backup

### PasswordResetsController
- **Index** (GET) - List password reset requests (Coordinator only)
- **Approve** (POST) - Approve password reset request

---

## Middleware

### AuditLoggingMiddleware
- **Location**: `Web/Middleware/AuditLoggingMiddleware.cs`
- **Purpose**: Automatically log HTTP actions (POST, PUT, DELETE)
- **Execution**: Runs after authentication, before controller action
- **Logged Actions**:
  - POST → "Create"
  - PUT → "Update"
  - DELETE → "Delete"
  - Login/Logout → Special handling
- **Entity Detection**: Extracts entity type from URL path
  - `/students/*` → "Student"
  - `/books/*` → "Book"
  - `/classes/*` → "Classroom"
  - etc.

### Session Timeout JavaScript
- **File**: `wwwroot/js/session-timeout.js`
- **Functionality**:
  - Tracks user activity (mouse, keyboard, scroll)
  - Shows warning modal 2 minutes before timeout
  - Auto-logout after 10 minutes of inactivity
  - Calls `/Account/KeepAlive` to extend session

---

## Deployment

### Production Server
- **URL**: http://dilmunreadingcoach.runasp.net/
- **Hosting**: runasp.net (Windows hosting)
- **Deployment Method**: MSDeploy (Web Deploy)

### Deployment Credentials
```
Server: site44897.siteasp.net
Site: site44897
Username: site44897
Password: Z=q58bX@-9kC
```

### Deployment Command
```powershell
dotnet publish src/DilmunReadingCoach.Web -c Release `
  /p:WebPublishMethod=MSDeploy `
  /p:MSDeployServiceURL=site44897.siteasp.net `
  /p:DeployIisAppPath=site44897 `
  /p:UserName=site44897 `
  /p:Password='Z=q58bX@-9kC' `
  /p:AllowUntrustedCertificate=True `
  /p:SkipExtraFilesOnServer=True
```

### Database Migration
```powershell
dotnet ef database update `
  --project src/DilmunReadingCoach.Infrastructure `
  --startup-project src/DilmunReadingCoach.Web `
  --connection "Server=db33679.public.databaseasp.net; Database=db33679; User Id=db33679; Password=Nz5?6%rKGc7!; Encrypt=True; TrustServerCertificate=True; MultipleActiveResultSets=True"
```

---

## Configuration

### appsettings.json
`src/DilmunReadingCoach.Web/appsettings.json` holds shared configuration:

- `ConnectionStrings:DefaultConnection` (remote SQL Server)
- `Logging:LogLevel` – default `Information`, ASP.NET Core `Warning`
- `AllowedHosts` – set to `*` for hosting provider

For local development, override values in `appsettings.Development.json`. Sensitive production secrets should ultimately live in environment variables or the hosting provider’s configuration instead of the repo.

### Environment Variables

| Variable | Purpose | Notes |
| --- | --- | --- |
| `ASPNETCORE_ENVIRONMENT` | Controls config file loading and error pages | Typically `Development` locally, `Production` on runasp.net |
| `ConnectionStrings__DefaultConnection` | Overrides JSON connection string | Optional, but preferred for secrets |

### Identity & Cookie Settings
Configured in `Program.cs`:

- Cookie lifetime 10 minutes with sliding expiration
- `CookieSecurePolicy.SameAsRequest` (supports HTTP on runasp.net)
- Lockout after 3 failed attempts for 10 minutes
- Password requires lowercase + digit (no uppercase/non-alphanumeric requirement)

---

## Seed Data

On application startup, `SeedDataAsync` ensures the database contains baseline data. Seeding runs inside `Program.cs` after DI container builds.

### Roles & Users
- Creates `Coordinator` and `Teacher` roles if missing.
- Creates default coordinator (username `coordinator`, password `Coordinator123!`).
- Seeds 15 teacher accounts (`teacher.ali`, `teacher.farah`, …) with password `Teacher123!`.

### Domain Entities
- **Classrooms**: 15 classes (Grades 1–5, sections A–C) marked Active.
- **Books**: 15 English-titled books with English authors/categories.
- **Students**: 15 students mapped to classrooms with codes `ST001`–`ST015`.
- **TeacherClasses**: Assigns teachers to classrooms (Dictionary in `EnsureTeacherClassesAsync`).
- **ReadingProgress**: One weekly entry per student for September–October 2024.
- **AuditLogs**: Sample activity for coordinator and teachers.

Seeding only inserts missing data; if tables already contain rows the helper skips them to avoid duplicates. To force reseed, clear relevant tables then restart the app.

---

## Logging & Monitoring

- **Audit Logging**: Captures every authenticated POST/PUT/DELETE via middleware plus explicit calls in controllers (login/logout).
- **ASP.NET Core Logging**: Default configuration logs to console/host environment; adjust `Logging` section in appsettings for more detail.
- **ReportCache**: Acts as a performance monitor—stale caches indicate report generation frequency.

Consider adding Application Insights or structured logging if moved to Azure/production hosting.

---

## Development Workflow

1. **Restore dependencies**
   ```powershell
   dotnet restore
   ```
2. **Build solution**
   ```powershell
   dotnet build DilmunReadingCoach.sln
   ```
3. **Run migrations locally**
   ```powershell
   dotnet ef database update --project src/DilmunReadingCoach.Infrastructure --startup-project src/DilmunReadingCoach.Web
   ```
4. **Run web project**
   ```powershell
   dotnet run --project src/DilmunReadingCoach.Web
   ```
5. **Publish (local folder)**
   ```powershell
   dotnet publish src/DilmunReadingCoach.Web -c Release -o publish
   ```

---

## Troubleshooting

| Issue | Cause | Resolution |
| --- | --- | --- |
| Login loops / session not sticking | Secure-only cookies on HTTP | Ensured `CookieSecurePolicy.SameAsRequest`; redeploy |
| `crypto.randomUUID` undefined | Browser in HTTP context | Add JS polyfill before other scripts |
| Cannot login with seeded accounts | Seed not run on remote DB | Temporarily run `dotnet run` on server connection to trigger seeding |
| EF migration errors | Connection string mismatch | Pass `--connection` explicitly when updating remote DB |
| SSMS connection failures | Wrong server/SSL | Use `db33679.public.databaseasp.net`, SQL Auth, Encrypt + TrustServerCertificate |

---

## Future Enhancements

- Move secrets to secure storage (key vault, environment variables).
- Add unit/integration tests for services.
- Introduce role-specific dashboards (widgets configurable in DB).
- Implement pagination on large lists (students, audit logs).
- Add background job for scheduled backups/report generation.

---

_Last updated: 2025-12-04_