## Dilmun Reading Coach System — Data & API Design

### 1. Database Overview
- **Engine**: Microsoft SQL Server (single catalog `DilmunReadingDb`).
- **ORM**: Entity Framework Core with code-first migrations.
- **Conventions**: `Id` as primary key (GUID) except lookup tables; `CreatedAt`/`UpdatedAt` UTC timestamps; soft-delete via `Status` or `IsActive`.
- **Security**: Transparent data encryption + encrypted backups; all tables stored on Bahrain-hosted server.

### 2. Core Tables

#### 2.1 `Users`
| Column | Type | Notes |
| --- | --- | --- |
| `Id` | uniqueidentifier | PK |
| `Username` | nvarchar(100) | Unique, indexed |
| `NormalizedUsername` | nvarchar(100) | For case-insensitive lookup |
| `PasswordHash` | nvarchar(max) | ASP.NET Identity hash |
| `Role` | varchar(20) | `Coordinator` or `Teacher` |
| `FirstName` | nvarchar(100) | |
| `LastName` | nvarchar(100) | |
| `Email` | nvarchar(256) | optional |
| `Phone` | nvarchar(30) | optional |
| `IsActive` | bit | defaults true |
| `LastLoginAt` | datetime2 | nullable |
| `CreatedAt` / `UpdatedAt` | datetime2 | timestamps |

Indexes: unique on `Username`; nonclustered on (`Role`, `IsActive`).

#### 2.2 `Classes`
| Column | Type | Notes |
| --- | --- | --- |
| `Id` | uniqueidentifier | PK |
| `Name` | nvarchar(100) | Unique |
| `YearGroup` | nvarchar(50) | optional |
| `Status` | varchar(20) | `Active`/`Inactive` |
| `CreatedAt` / `UpdatedAt` | datetime2 | |

#### 2.3 `TeacherClasses`
Maps teachers to assigned classes (many-to-many to allow coverage).

| Column | Type | Notes |
| --- | --- | --- |
| `TeacherId` | uniqueidentifier | FK -> `Users(Id)` |
| `ClassId` | uniqueidentifier | FK -> `Classes(Id)` |
| PK | composite (`TeacherId`,`ClassId`) |

#### 2.4 `Students`
| Column | Type | Notes |
| --- | --- | --- |
| `Id` | uniqueidentifier | PK |
| `StudentCode` | nvarchar(50) | School-provided ID, unique |
| `FirstName` / `LastName` | nvarchar(100) | |
| `Gender` | varchar(10) | optional |
| `DateOfBirth` | date | optional |
| `ClassId` | uniqueidentifier | FK -> `Classes` |
| `ReadingLevel` | nvarchar(50) | latest known |
| `Status` | varchar(20) | `Active`/`Inactive` |
| `CreatedAt` / `UpdatedAt` | datetime2 | |

Indexes: unique on `StudentCode`; nonclustered on (`ClassId`,`Status`).

#### 2.5 `Books`
| Column | Type | Notes |
| --- | --- | --- |
| `Id` | uniqueidentifier | PK |
| `Title` | nvarchar(200) | Unique with Author |
| `Author` | nvarchar(150) | |
| `Category` | nvarchar(100) | |
| `ReadingLevel` | nvarchar(50) | |
| `Status` | varchar(20) | `Available`/`Inactive` |
| `CreatedAt` / `UpdatedAt` | datetime2 | |

Unique index on (`Title`,`Author`).

#### 2.6 `ReadingProgress`
| Column | Type | Notes |
| --- | --- | --- |
| `Id` | uniqueidentifier | PK |
| `StudentId` | uniqueidentifier | FK -> `Students` |
| `TeacherId` | uniqueidentifier | FK -> `Users` |
| `BookId` | uniqueidentifier | FK -> `Books`, nullable |
| `WeekStartDate` | date | Monday of week (unique key) |
| `ReadingLevel` | nvarchar(50) | |
| `DurationMinutes` | int | >=0 |
| `Notes` | nvarchar(500) | optional |
| `CreatedAt` / `UpdatedAt` | datetime2 | |

Constraints: unique index on (`StudentId`,`WeekStartDate`); check constraint ensures `DurationMinutes >= 0`.

#### 2.7 `ReportsCache`
Stores pre-aggregated data for fast dashboard/report loads.

| Column | Type | Notes |
| --- | --- | --- |
| `Id` | uniqueidentifier | PK |
| `ReportType` | varchar(20) | `Weekly`/`Term`/`Dashboard` |
| `ScopeId` | uniqueidentifier | Student/Class/School depending on type |
| `PeriodStart` / `PeriodEnd` | date | |
| `PayloadJson` | nvarchar(max) | serialized metrics |
| `GeneratedAt` | datetime2 | |

#### 2.8 `PasswordResetRequests`
| Column | Type | Notes |
| --- | --- | --- |
| `Id` | uniqueidentifier | PK |
| `UserId` | uniqueidentifier | FK -> `Users` |
| `RequestedAt` | datetime2 | |
| `ApprovedBy` | uniqueidentifier | FK -> `Users` (coordinator), nullable |
| `ApprovedAt` | datetime2 | nullable |
| `Status` | varchar(20) | `Pending`/`Approved`/`Rejected` |

#### 2.9 `Backups`
| Column | Type | Notes |
| --- | --- | --- |
| `Id` | uniqueidentifier | PK |
| `FileName` | nvarchar(260) | Path within secure storage |
| `StartedAt` / `CompletedAt` | datetime2 | |
| `Type` | varchar(20) | `Automatic` / `Manual` |
| `Status` | varchar(20) | `Success` / `Failed` / `InProgress` |
| `TriggeredBy` | uniqueidentifier | nullable FK -> `Users` |
| `Notes` | nvarchar(500) | failure details |

#### 2.10 `AuditLogs`
| Column | Type | Notes |
| --- | --- | --- |
| `Id` | bigint identity | PK |
| `UserId` | uniqueidentifier | FK -> `Users` |
| `ActionType` | varchar(30) | `Login`,`Logout`,`Create`,`Update`,`Delete`,`Backup`,`Restore` |
| `Entity` | varchar(100) | e.g., `Student`, `ReadingProgress` |
| `EntityId` | uniqueidentifier | nullable |
| `Description` | nvarchar(500) | |
| `IpAddress` | varchar(45) | |
| `CreatedAt` | datetime2 | |

Retention policy enforced via SQL Agent job (purge records >6 months).

#### 2.11 `SystemSettings`
Stores configurable values (session timeout warnings, dashboard thresholds, etc.).

| Column | Type | Notes |
| --- | --- | --- |
| `Key` | varchar(100) | PK |
| `Value` | nvarchar(500) | |
| `UpdatedAt` | datetime2 | |


### 3. Relationships & Integrity
- `Users` 1..* `TeacherClasses` -> `Classes`
- `Classes` 1..* `Students`
- `Students` 1..* `ReadingProgress`
- `Users` (teachers) 1..* `ReadingProgress`
- `Books` 1..* `ReadingProgress`
- `Backups` optionally reference the coordinator who triggered them.
- Cascading deletes disabled; use soft deletes and enforce referential integrity in services.

### 4. Stored Procedures / Views (Optional Enhancements)
- `sp_GenerateWeeklyReport(@ClassId, @WeekStart)` – returns summary metrics for UI/export.
- `sp_GenerateTermReport(@TermStart, @TermEnd, @Scope)` – coordinator exports.
- `vw_StudentLatestReading` – denormalized view for dashboards showing last level + minutes.
- `vw_MissingEntries` – lists students lacking entries for the current week.

### 5. API & Controller Endpoints

| Module | Endpoint | Method | Description | Roles |
| --- | --- | --- | --- | --- |
| Auth | `/account/login` | POST | Username/password login | All |
| Auth | `/account/logout` | POST | Ends session | All |
| Students | `/students` | GET | List/search with filters | Coordinator |
| Students | `/students` | POST | Create student | Coordinator |
| Students | `/students/{id}` | PUT | Update student | Coordinator |
| Students | `/students/{id}/status` | PATCH | Activate/deactivate | Coordinator |
| Students | `/students/bulk-upload` | POST | CSV import | Coordinator |
| Teachers | `/teachers` | GET/POST/PUT | Manage staff | Coordinator |
| Teachers | `/teachers/{id}/reset-request` | POST | Approve reset | Coordinator |
| Classes | `/classes` | CRUD | Manage classes | Coordinator |
| Books | `/books` | GET | Search/filter | Both (read) |
| Books | `/books` | POST/PUT | Manage catalogue | Coordinator |
| Reading | `/reading-records` | GET | Filter by class/week | Teacher (own classes), Coordinator |
| Reading | `/reading-records` | POST | Add entry | Teacher (own class) |
| Reading | `/reading-records/{id}` | PUT | Edit entry | Owner teacher + coordinator |
| Dashboard | `/dashboard/coordinator` | GET | KPIs | Coordinator |
| Dashboard | `/dashboard/teacher` | GET | KPIs | Teacher |
| Reports | `/reports/weekly` | GET | Generate PDF/Excel | Scoped |
| Reports | `/reports/term` | GET | Generate PDF/Excel | Scoped |
| Backups | `/backups` | GET | Status/history | Coordinator |
| Backups | `/backups` | POST | Trigger manual backup | Coordinator |
| Backups | `/backups/restore` | POST | Restore DB | Coordinator |
| Logs | `/logs` | GET | Audit trail filter | Coordinator |
| Password Reset | `/password-resets` | POST | Teacher request | Teacher |
| Password Reset | `/password-resets/{id}/approve` | POST | Coordinator approval | Coordinator |

All endpoints surface via MVC controllers now; same URLs will back future REST API by returning JSON when requested via `Accept: application/json`.

### 6. Validation & Constraints
- Duplicate prevention handled via unique constraints and EF validation (students, teachers, books, weekly reading entries).
- CSV import runs server-side validation: required fields, class existence, book existence, duplicate detection before commit.
- Business rules enforced in service layer (teachers limited to assigned classes; coordinator override).

### 7. Backup & Maintenance Jobs
- **Automatic backup job**: nightly SQL Agent job executing `BACKUP DATABASE DilmunReadingDb` to encrypted storage; logs entry in `Backups`.
- **Log retention job**: weekly purge job deleting `AuditLogs` older than 180 days.
- **Reports cache refresh**: scheduled task recalculating aggregates for dashboards each hour during school hours.

### 8. Migration Strategy
- Use EF Core migrations; prefix migration names with timestamp (e.g., `20250115_InitialCreate`).
- Seed data for coordinator account, default classes, and sample books via `ModelBuilder.Seed`.
- Deploy database via DACPAC or migration bundle to Bahrain SQL Server instance.

