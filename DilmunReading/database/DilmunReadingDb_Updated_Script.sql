/****** Object:  Database [db33679]    Script Date: 11/30/2025 4:50:43 PM ******/
CREATE DATABASE [db33679]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'db33679', FILENAME = N'D:\Services\MSSQL\Data\db33679.mdf' , SIZE = 8192KB , MAXSIZE = 1048576KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'db33679_log', FILENAME = N'D:\Services\MSSQL\Data\db33679_log.ldf' , SIZE = 8192KB , MAXSIZE = 5242880KB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [db33679] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [db33679].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [db33679] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [db33679] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [db33679] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [db33679] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [db33679] SET ARITHABORT OFF 
GO
ALTER DATABASE [db33679] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [db33679] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [db33679] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [db33679] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [db33679] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [db33679] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [db33679] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [db33679] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [db33679] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [db33679] SET  ENABLE_BROKER 
GO
ALTER DATABASE [db33679] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [db33679] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [db33679] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [db33679] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [db33679] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [db33679] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [db33679] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [db33679] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [db33679] SET  MULTI_USER 
GO
ALTER DATABASE [db33679] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [db33679] SET DB_CHAINING OFF 
GO
ALTER DATABASE [db33679] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [db33679] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [db33679] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [db33679] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [db33679] SET QUERY_STORE = ON
GO
ALTER DATABASE [db33679] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
/****** Object:  FullTextCatalog [db33679]    Script Date: 11/30/2025 4:50:46 PM ******/
CREATE FULLTEXT CATALOG [db33679] WITH ACCENT_SENSITIVITY = ON
AS DEFAULT
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 11/30/2025 4:50:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuditLogs]    Script Date: 11/30/2025 4:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditLogs](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[ActionType] [nvarchar](max) NOT NULL,
	[Entity] [nvarchar](max) NULL,
	[EntityId] [uniqueidentifier] NULL,
	[Description] [nvarchar](max) NULL,
	[IpAddress] [nvarchar](max) NULL,
	[CreatedAtUtc] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_AuditLogs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BackupRecords]    Script Date: 11/30/2025 4:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BackupRecords](
	[Id] [uniqueidentifier] NOT NULL,
	[FileName] [nvarchar](max) NOT NULL,
	[StartedAtUtc] [datetime2](7) NOT NULL,
	[CompletedAtUtc] [datetime2](7) NULL,
	[Type] [nvarchar](max) NOT NULL,
	[Status] [nvarchar](max) NOT NULL,
	[TriggeredBy] [uniqueidentifier] NULL,
	[Notes] [nvarchar](max) NULL,
	[CreatedAtUtc] [datetime2](7) NOT NULL,
	[UpdatedAtUtc] [datetime2](7) NULL,
 CONSTRAINT [PK_BackupRecords] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Books]    Script Date: 11/30/2025 4:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Books](
	[Id] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[Author] [nvarchar](150) NOT NULL,
	[Category] [nvarchar](max) NOT NULL,
	[ReadingLevel] [nvarchar](max) NOT NULL,
	[Status] [nvarchar](max) NOT NULL,
	[CreatedAtUtc] [datetime2](7) NOT NULL,
	[UpdatedAtUtc] [datetime2](7) NULL,
 CONSTRAINT [PK_Books] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Classrooms]    Script Date: 11/30/2025 4:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Classrooms](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[YearGroup] [nvarchar](max) NULL,
	[Status] [nvarchar](max) NOT NULL,
	[CreatedAtUtc] [datetime2](7) NOT NULL,
	[UpdatedAtUtc] [datetime2](7) NULL,
 CONSTRAINT [PK_Classrooms] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PasswordResetRequests]    Script Date: 11/30/2025 4:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PasswordResetRequests](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[Status] [nvarchar](max) NOT NULL,
	[ApprovedBy] [uniqueidentifier] NULL,
	[ApprovedAtUtc] [datetime2](7) NULL,
	[CreatedAtUtc] [datetime2](7) NOT NULL,
	[UpdatedAtUtc] [datetime2](7) NULL,
 CONSTRAINT [PK_PasswordResetRequests] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReadingProgress]    Script Date: 11/30/2025 4:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReadingProgress](
	[Id] [uniqueidentifier] NOT NULL,
	[StudentId] [uniqueidentifier] NOT NULL,
	[TeacherId] [uniqueidentifier] NOT NULL,
	[BookId] [uniqueidentifier] NULL,
	[WeekStartDate] [date] NOT NULL,
	[ReadingLevel] [nvarchar](max) NOT NULL,
	[DurationMinutes] [int] NOT NULL,
	[Notes] [nvarchar](max) NULL,
	[CreatedAtUtc] [datetime2](7) NOT NULL,
	[UpdatedAtUtc] [datetime2](7) NULL,
 CONSTRAINT [PK_ReadingProgress] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReportCaches]    Script Date: 11/30/2025 4:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReportCaches](
	[Id] [uniqueidentifier] NOT NULL,
	[ReportType] [nvarchar](450) NOT NULL,
	[ScopeId] [uniqueidentifier] NULL,
	[PeriodStart] [date] NOT NULL,
	[PeriodEnd] [date] NOT NULL,
	[PayloadJson] [nvarchar](max) NOT NULL,
	[CreatedAtUtc] [datetime2](7) NOT NULL,
	[UpdatedAtUtc] [datetime2](7) NULL,
 CONSTRAINT [PK_ReportCaches] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleClaims]    Script Date: 11/30/2025 4:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_RoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 11/30/2025 4:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 11/30/2025 4:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[Id] [uniqueidentifier] NOT NULL,
	[StudentCode] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](max) NOT NULL,
	[LastName] [nvarchar](max) NOT NULL,
	[Gender] [nvarchar](max) NULL,
	[DateOfBirth] [datetime2](7) NULL,
	[ClassroomId] [uniqueidentifier] NOT NULL,
	[ReadingLevel] [nvarchar](max) NOT NULL,
	[Status] [nvarchar](450) NOT NULL,
	[CreatedAtUtc] [datetime2](7) NOT NULL,
	[UpdatedAtUtc] [datetime2](7) NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SystemSettings]    Script Date: 11/30/2025 4:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemSettings](
	[Key] [nvarchar](450) NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
	[UpdatedAtUtc] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_SystemSettings] PRIMARY KEY CLUSTERED 
(
	[Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeacherClasses]    Script Date: 11/30/2025 4:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeacherClasses](
	[TeacherId] [uniqueidentifier] NOT NULL,
	[ClassroomId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_TeacherClasses] PRIMARY KEY CLUSTERED 
(
	[TeacherId] ASC,
	[ClassroomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserClaims]    Script Date: 11/30/2025 4:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_UserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserLogins]    Script Date: 11/30/2025 4:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserLogins](
	[LoginProvider] [nvarchar](450) NOT NULL,
	[ProviderKey] [nvarchar](450) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_UserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 11/30/2025 4:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[UserId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 11/30/2025 4:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [uniqueidentifier] NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[Role] [nvarchar](20) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedAtUtc] [datetime2](7) NOT NULL,
	[UpdatedAtUtc] [datetime2](7) NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserTokens]    Script Date: 11/30/2025 4:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTokens](
	[UserId] [uniqueidentifier] NOT NULL,
	[LoginProvider] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](450) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_UserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20251121113335_InitialCreate', N'8.0.10')
GO
SET IDENTITY_INSERT [dbo].[AuditLogs] ON 
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (1, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Login', N'System', NULL, N'Coordinator login', N'192.168.1.20', CAST(N'2025-11-16T09:10:37.7303663' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (2, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Create', N'Classroom', N'4db36147-0d00-4b9f-b01e-38c4961d75ae', N'Created Class 1C', N'192.168.1.20', CAST(N'2025-11-17T09:10:37.7356554' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (3, N'4a998dd6-c766-4244-afb7-08de2e5de8a7', N'Login', N'System', NULL, N'Teacher Ali login', N'192.168.1.20', CAST(N'2025-11-18T09:10:37.7356631' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (4, N'4a998dd6-c766-4244-afb7-08de2e5de8a7', N'Create', N'Student', N'eb9de0d1-0c98-4721-b238-daea3d36fca7', N'Logged reading session for Ahmad', N'192.168.1.20', CAST(N'2025-11-18T09:10:37.7356654' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (5, N'd3f515ba-edfc-4f10-afb8-08de2e5de8a7', N'Update', N'Student', N'f91496c3-8833-430d-bb7e-216c957318f7', N'Updated Sara profile', N'192.168.1.20', CAST(N'2025-11-19T09:10:37.7356665' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (6, N'dcf948a5-9dbe-4611-afb9-08de2e5de8a7', N'Create', N'Student', N'3c67eed7-9aa0-40ac-b882-ec56e62c483d', N'Recorded Noura practice', N'192.168.1.20', CAST(N'2025-11-19T09:10:37.7356693' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (7, N'392526be-cae1-4ea5-afba-08de2e5de8a7', N'Create', N'Student', N'0d1dfd76-6235-48be-9dfc-7fc43ce1ff98', N'Documented Hamad progress', N'192.168.1.20', CAST(N'2025-11-20T09:10:37.7356705' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (8, N'c374d224-0e43-4026-afbb-08de2e5de8a7', N'Create', N'Student', N'f045cc26-40e5-4521-ac57-508fd52ee8bb', N'Submitted Omar weekly report', N'192.168.1.20', CAST(N'2025-11-21T09:10:37.7356715' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (9, N'abab7932-9628-4e11-afbc-08de2e5de8a7', N'Update', N'Classroom', N'a8d7cd5c-43e7-456d-ac85-b60a2eb090b2', N'Adjusted Class 4B plan', N'192.168.1.20', CAST(N'2025-11-21T09:10:37.7356728' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (10, N'c25bd4c4-f334-47fd-afbd-08de2e5de8a7', N'Create', N'Student', N'4c9625ac-e200-4775-988c-cb482860776f', N'Added Sami progress', N'192.168.1.20', CAST(N'2025-11-22T09:10:37.7356739' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (11, N'384c9d3f-da23-4107-afbe-08de2e5de8a7', N'Create', N'Student', N'd257cf93-e3e1-4ac4-8630-0cef055d0eb9', N'Captured Dana reading', N'192.168.1.20', CAST(N'2025-11-22T09:10:37.7356747' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (12, N'da6a8fac-f2bf-4a0a-afbf-08de2e5de8a7', N'Create', N'Student', N'00e89d8a-42a0-4d6a-94ca-b8e6028c9174', N'Recorded Rakan session', N'192.168.1.20', CAST(N'2025-11-23T09:10:37.7356754' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (13, N'3a9dd813-55e2-406c-afc0-08de2e5de8a7', N'Create', N'Book', N'f175536b-14c7-45aa-9041-01de162c91b6', N'Suggested new resource', N'192.168.1.20', CAST(N'2025-11-24T09:10:37.7356784' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (14, N'abe16bd7-cf52-4e3c-afc1-08de2e5de8a7', N'Delete', N'Student', N'233c10c4-a0d6-4c63-8640-f3ef53a1480b', N'Removed duplicate entry', N'192.168.1.20', CAST(N'2025-11-25T09:10:37.7356793' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (15, N'51e67371-86c6-4347-afc4-08de2e5de8a7', N'Login', N'System', NULL, N'Teacher Nour login', N'192.168.1.20', CAST(N'2025-11-26T09:10:37.7356800' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (16, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Login', NULL, NULL, N'User coordinator logged in', N'::1', CAST(N'2025-11-28T09:12:38.8541201' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (17, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Create', NULL, NULL, N'Create action on ', N'::1', CAST(N'2025-11-28T09:13:45.0600930' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (18, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Create', N'Student', N'c70a4b84-2c8e-4d71-972c-25f9bb5bc614', N'Create Student', N'::1', CAST(N'2025-11-28T09:13:45.5095233' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (19, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Create', NULL, NULL, N'Create action on ', N'::1', CAST(N'2025-11-28T09:14:58.4933179' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (20, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Create', N'Teacher', N'b0e95f85-ebe8-42c0-8b67-813e292b571f', N'Create Teacher', N'::1', CAST(N'2025-11-28T09:15:00.6855476' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (21, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Logout', NULL, NULL, N'Logout action on ', N'::1', CAST(N'2025-11-28T09:15:23.6076572' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (22, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Logout', NULL, NULL, N'User logged out', N'::1', CAST(N'2025-11-28T09:15:23.7969358' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (23, N'b0e95f85-ebe8-42c0-8b67-813e292b571f', N'Login', NULL, NULL, N'User teacher.faizan logged in', N'::1', CAST(N'2025-11-28T09:15:39.3321876' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (24, N'b0e95f85-ebe8-42c0-8b67-813e292b571f', N'Create', NULL, NULL, N'Create action on ', N'::1', CAST(N'2025-11-28T09:16:18.0695851' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (25, N'b0e95f85-ebe8-42c0-8b67-813e292b571f', N'Logout', NULL, NULL, N'Logout action on ', N'::1', CAST(N'2025-11-28T09:16:34.0551130' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (26, N'b0e95f85-ebe8-42c0-8b67-813e292b571f', N'Logout', NULL, NULL, N'User logged out', N'::1', CAST(N'2025-11-28T09:16:34.2074755' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (27, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Login', NULL, NULL, N'User coordinator logged in', N'::1', CAST(N'2025-11-28T09:17:56.3630243' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (28, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Login', NULL, NULL, N'User coordinator logged in', N'103.170.179.203', CAST(N'2025-11-28T09:30:06.3275762' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (29, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Login', NULL, NULL, N'User coordinator logged in', N'103.170.179.203', CAST(N'2025-11-28T09:30:24.4332092' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (30, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Login', NULL, NULL, N'User coordinator logged in', N'103.170.179.203', CAST(N'2025-11-28T09:30:53.8354656' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (31, N'b0e95f85-ebe8-42c0-8b67-813e292b571f', N'Login', NULL, NULL, N'User teacher.faizan logged in', N'103.170.179.203', CAST(N'2025-11-28T09:31:26.2433115' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (32, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Login', NULL, NULL, N'User coordinator logged in', N'103.170.179.203', CAST(N'2025-11-28T09:39:55.8727603' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (33, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Login', NULL, NULL, N'User coordinator logged in', N'103.170.179.203', CAST(N'2025-11-28T09:40:26.2350350' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (34, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Login', NULL, NULL, N'User coordinator logged in', N'103.170.179.203', CAST(N'2025-11-28T09:45:36.0351735' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (35, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Create', NULL, NULL, N'Create action on ', N'103.170.179.203', CAST(N'2025-11-28T09:46:40.7727622' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (36, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Create', N'Student', N'3b4ea0ed-ef7e-4ebc-931c-e87a79206672', N'Create Student', N'103.170.179.203', CAST(N'2025-11-28T09:46:40.8245564' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (37, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Login', NULL, NULL, N'User coordinator logged in', N'103.170.179.203', CAST(N'2025-11-28T09:49:37.8904521' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (38, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Login', NULL, NULL, N'User coordinator logged in', N'103.170.179.203', CAST(N'2025-11-28T12:09:10.9544606' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (39, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Logout', NULL, NULL, N'Logout action on ', N'103.170.179.203', CAST(N'2025-11-28T12:11:20.9111687' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (40, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Logout', NULL, NULL, N'User logged out', N'103.170.179.203', CAST(N'2025-11-28T12:11:20.9257268' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (41, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Login', NULL, NULL, N'User coordinator logged in', N'103.170.179.203', CAST(N'2025-11-28T12:15:29.9932287' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (42, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Login', NULL, NULL, N'User coordinator logged in', N'89.148.42.34', CAST(N'2025-11-29T12:39:18.0785740' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (43, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Login', NULL, NULL, N'User coordinator logged in', N'109.161.220.87', CAST(N'2025-11-29T12:49:35.3167183' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (44, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Login', NULL, NULL, N'User coordinator logged in', N'103.170.179.203', CAST(N'2025-11-29T12:57:37.3256079' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (45, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Logout', NULL, NULL, N'Logout action on ', N'103.170.179.203', CAST(N'2025-11-29T13:02:44.1472775' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (46, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Logout', NULL, NULL, N'User logged out', N'103.170.179.203', CAST(N'2025-11-29T13:02:44.1566790' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (47, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Login', NULL, NULL, N'User coordinator logged in', N'109.161.220.87', CAST(N'2025-11-29T13:06:35.7140638' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (48, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Login', NULL, NULL, N'User coordinator logged in', N'89.148.42.34', CAST(N'2025-11-29T23:42:28.2097286' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (49, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Login', NULL, NULL, N'User coordinator logged in', N'103.170.179.203', CAST(N'2025-11-30T11:29:53.7209969' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (50, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Login', NULL, NULL, N'User coordinator logged in', N'103.170.179.203', CAST(N'2025-11-30T11:31:59.6783068' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (51, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Login', NULL, NULL, N'User coordinator logged in', N'103.170.179.203', CAST(N'2025-11-30T11:35:54.3293174' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (52, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Logout', NULL, NULL, N'Logout action on ', N'103.170.179.203', CAST(N'2025-11-30T11:42:59.6329469' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (53, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Logout', NULL, NULL, N'User logged out', N'103.170.179.203', CAST(N'2025-11-30T11:42:59.6544905' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (54, N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'Login', NULL, NULL, N'User coordinator logged in', N'89.148.42.34', CAST(N'2025-11-30T11:45:51.8070431' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[AuditLogs] OFF
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'f175536b-14c7-45aa-9041-01de162c91b6', N'The Art of Reading', N'Christopher Lee', N'Guide', N'Level 5', N'Available', CAST(N'2025-11-28T09:10:33.5295598' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'383ae7e5-301d-4ba4-9daa-1b7e4ca3c896', N'The Pulse of Words', N'Matthew Walker', N'Literary', N'Level 4', N'Available', CAST(N'2025-11-28T09:10:33.5295626' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'9b2cb7f4-fa9d-4c4e-9311-245391e2cf6b', N'The Train of Dreams', N'Michael Brown', N'Inspirational', N'Level 1', N'Available', CAST(N'2025-11-28T09:10:33.5295244' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'803f1c65-a608-47a2-bdb9-34823e2f093c', N'Paths to the Stars', N'Amanda Martinez', N'Science', N'Level 3', N'Available', CAST(N'2025-11-28T09:10:33.5295585' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'348a5087-047d-468d-8cf4-40fcf2fdab10', N'The Castle of Seas', N'James Thompson', N'Adventure', N'Level 4', N'Available', CAST(N'2025-11-28T09:10:33.5295589' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'37500367-d35f-40cb-aaec-84c82869adf4', N'The Lantern of Stories', N'Jessica Lewis', N'Short Story', N'Level 3', N'Available', CAST(N'2025-11-28T09:10:33.5295622' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'8de0e09a-6a6f-4a58-b6a4-8657e653156a', N'The Secret of Lulu''s Oasis', N'Emily Johnson', N'Adventure', N'Level 3', N'Available', CAST(N'2025-11-28T09:10:33.5295236' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'3e7314f2-451e-48c5-a587-8efd302ebff2', N'Islands of Pearls', N'David Wilson', N'Fantasy', N'Level 5', N'Available', CAST(N'2025-11-28T09:10:33.5295278' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'4aac51a2-a873-468e-b311-9cf1d5859d10', N'Strings of the Moon', N'Michelle Harris', N'Fantasy', N'Level 6', N'Available', CAST(N'2025-11-28T09:10:33.5295613' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'409de64e-b492-4564-ab1d-a7ecd8c2059d', N'The Desert Book', N'Daniel Clark', N'Adventure', N'Level 2', N'Available', CAST(N'2025-11-28T09:10:33.5295617' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'ae176427-c7b1-46ff-a106-aa067175d947', N'Waves of Freedom', N'Robert Taylor', N'Poetry', N'Level 6', N'Available', CAST(N'2025-11-28T09:10:33.5295581' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'74827977-5773-4cd2-824e-ce307d818043', N'Nour''s Journey', N'Patricia White', N'Educational', N'Level 1', N'Available', CAST(N'2025-11-28T09:10:33.5295594' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'3f87c954-5129-4393-95cb-d564cf92b0d7', N'The Planet of Wisdom', N'Jennifer Davis', N'Educational', N'Level 4', N'Available', CAST(N'2025-11-28T09:10:33.5295274' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'2b3251b4-b36f-4777-aa74-f514ca1eac87', N'Tales of the Sea', N'Sarah Mitchell', N'Short Story', N'Level 2', N'Available', CAST(N'2025-11-28T09:10:33.5292271' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'80305c06-3a5f-4b29-9fcb-f6ebdcfeffa9', N'The Treasure Box', N'Lisa Anderson', N'Series', N'Level 2', N'Available', CAST(N'2025-11-28T09:10:33.5295568' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'94a5ce45-c184-4f87-946a-26ee5748f564', N'Class 4A', N'Grade 4', N'Active', CAST(N'2025-11-28T09:10:32.9660150' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'4db36147-0d00-4b9f-b01e-38c4961d75ae', N'Class 1C', N'Grade 1', N'Active', CAST(N'2025-11-28T09:10:32.9659934' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'f8b49fc6-a76e-41ca-a6b4-3f7ec1dcb066', N'Class 2A', N'Grade 2', N'Active', CAST(N'2025-11-28T09:10:32.9659937' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'00ed7ef1-1d0e-4b6a-ba2a-40b8f298f85e', N'Class 3C', N'Grade 3', N'Active', CAST(N'2025-11-28T09:10:32.9660147' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'3287c77f-ff24-41d1-a690-53d92b9f9886', N'Class 1B', N'Grade 1', N'Active', CAST(N'2025-11-28T09:10:32.9659911' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'0bef3ada-1789-4645-91d7-6edb181c0ea8', N'Class 3B', N'Grade 3', N'Active', CAST(N'2025-11-28T09:10:32.9659948' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'7a517fc2-fa10-4f81-b40a-7f06a2d60e8f', N'Class 5C', N'Grade 5', N'Active', CAST(N'2025-11-28T09:10:32.9660168' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'53474655-3e11-402c-b8b4-87a16e9690f5', N'Class 5B', N'Grade 5', N'Active', CAST(N'2025-11-28T09:10:32.9660166' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'b78f7a58-f0ef-4e53-9d89-96b928fc0dca', N'Class 1A', N'Grade 1', N'Active', CAST(N'2025-11-28T09:10:32.9658243' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'c9e40b76-7b24-49ff-aa81-97f30c7a77bd', N'Class 4C', N'Grade 4', N'Active', CAST(N'2025-11-28T09:10:32.9660161' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'fe7e599e-93aa-4389-81ea-9b5757ff79ac', N'Class 2C', N'Grade 2', N'Active', CAST(N'2025-11-28T09:10:32.9659942' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'a8d7cd5c-43e7-456d-ac85-b60a2eb090b2', N'Class 4B', N'Grade 4', N'Active', CAST(N'2025-11-28T09:10:32.9660158' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'ad2587c4-83dc-47ba-a78d-c9f5cd7b558a', N'Class 5A', N'Grade 5', N'Active', CAST(N'2025-11-28T09:10:32.9660163' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'c6f967eb-12a6-4e39-88c5-dbdc76d0c2ab', N'Class 3A', N'Grade 3', N'Active', CAST(N'2025-11-28T09:10:32.9659945' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'7b0047d6-01ee-472d-88ec-f99b507d8f24', N'Class 2B', N'Grade 2', N'Active', CAST(N'2025-11-28T09:10:32.9659940' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'6c29d748-c711-4a08-8c48-0913adf6fdd0', N'4c9625ac-e200-4775-988c-cb482860776f', N'c25bd4c4-f334-47fd-afbd-08de2e5de8a7', N'409de64e-b492-4564-ab1d-a7ecd8c2059d', CAST(N'2024-10-14' AS Date), N'Level 5', 65, N'Engages classmates', CAST(N'2025-11-28T09:10:36.6557476' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'cebc0499-bc01-41d3-98cf-13f07c84c231', N'5143f723-867e-421b-bd84-2fd28780d8ce', N'd3f515ba-edfc-4f10-afb8-08de2e5de8a7', N'8de0e09a-6a6f-4a58-b6a4-8657e653156a', CAST(N'2024-09-09' AS Date), N'Level 3', 50, N'Excellent comprehension', CAST(N'2025-11-28T09:10:36.6557243' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'e879792c-30af-433d-9bb5-1688dc39338d', N'97df50af-98bb-46e6-b552-cc0eee41ee49', N'abab7932-9628-4e11-afbc-08de2e5de8a7', N'f175536b-14c7-45aa-9041-01de162c91b6', CAST(N'2024-10-07' AS Date), N'Level 4', 40, N'Working on tone', CAST(N'2025-11-28T09:10:36.6557444' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'ffb10e36-a85f-44bf-bc03-34b3b426a2dd', N'87503a49-920f-4ee4-8a56-d9e21a833d75', N'392526be-cae1-4ea5-afba-08de2e5de8a7', N'803f1c65-a608-47a2-bdb9-34823e2f093c', CAST(N'2024-09-23' AS Date), N'Level 4', 45, N'Solid vocabulary', CAST(N'2025-11-28T09:10:36.6557365' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'85306128-33a7-4a68-a709-42482f7b3909', N'510b3779-683d-4e54-b7fa-1e0ed43f5c08', N'abab7932-9628-4e11-afbc-08de2e5de8a7', N'4aac51a2-a873-468e-b311-9cf1d5859d10', CAST(N'2024-10-07' AS Date), N'Level 4', 55, N'Detailed observations', CAST(N'2025-11-28T09:10:36.6557456' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'3cd17c48-95a0-46e7-86df-4c93d8b70f40', N'f91496c3-8833-430d-bb7e-216c957318f7', N'd3f515ba-edfc-4f10-afb8-08de2e5de8a7', N'3f87c954-5129-4393-95cb-d564cf92b0d7', CAST(N'2024-09-09' AS Date), N'Level 2', 35, N'Improving pacing', CAST(N'2025-11-28T09:10:36.6557254' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'8c66b18a-925e-4d6b-881a-6aafa86aa168', N'233c10c4-a0d6-4c63-8640-f3ef53a1480b', N'4a998dd6-c766-4244-afb7-08de2e5de8a7', N'9b2cb7f4-fa9d-4c4e-9311-245391e2cf6b', CAST(N'2024-09-02' AS Date), N'Level 1', 30, N'Needs vowel practice', CAST(N'2025-11-28T09:10:36.6557215' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'09acec8a-cbbb-4a47-b5b5-6d23bb71cb03', N'f045cc26-40e5-4521-ac57-508fd52ee8bb', N'c374d224-0e43-4026-afbb-08de2e5de8a7', N'348a5087-047d-468d-8cf4-40fcf2fdab10', CAST(N'2024-09-30' AS Date), N'Level 6', 70, N'Leadership in group reading', CAST(N'2025-11-28T09:10:36.6557377' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'c2855698-4d60-4dd1-961a-89696724be82', N'0d1dfd76-6235-48be-9dfc-7fc43ce1ff98', N'392526be-cae1-4ea5-afba-08de2e5de8a7', N'ae176427-c7b1-46ff-a106-aa067175d947', CAST(N'2024-09-23' AS Date), N'Level 5', 55, N'Powerful expression', CAST(N'2025-11-28T09:10:36.6557353' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'2ad992db-b759-4ca5-9970-a7378c68b22c', N'00e89d8a-42a0-4d6a-94ca-b8e6028c9174', N'da6a8fac-f2bf-4a0a-afbf-08de2e5de8a7', N'383ae7e5-301d-4ba4-9daa-1b7e4ca3c896', CAST(N'2024-10-21' AS Date), N'Level 6', 50, N'Great critical thinking', CAST(N'2025-11-28T09:10:36.6557500' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'aedd510e-205e-44c7-a2ea-af0c500a4e69', N'3c67eed7-9aa0-40ac-b882-ec56e62c483d', N'dcf948a5-9dbe-4611-afb9-08de2e5de8a7', N'80305c06-3a5f-4b29-9fcb-f6ebdcfeffa9', CAST(N'2024-09-16' AS Date), N'Level 3', 40, N'Great focus', CAST(N'2025-11-28T09:10:36.6557339' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'f9f5db0c-8d1f-4c30-bfd8-bf3ed2aeaf47', N'5a846331-d547-40c8-8c5e-727e7c306c87', N'dcf948a5-9dbe-4611-afb9-08de2e5de8a7', N'3e7314f2-451e-48c5-a587-8efd302ebff2', CAST(N'2024-09-16' AS Date), N'Level 4', 60, N'Confident narrator', CAST(N'2025-11-28T09:10:36.6557301' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'6d96900f-d326-4b01-872e-c3a5422312d8', N'eb9de0d1-0c98-4721-b238-daea3d36fca7', N'4a998dd6-c766-4244-afb7-08de2e5de8a7', N'2b3251b4-b36f-4777-aa74-f514ca1eac87', CAST(N'2024-09-02' AS Date), N'Level 2', 45, N'Strong fluency', CAST(N'2025-11-28T09:10:36.6546960' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'7f7f5e33-5d6c-4a71-9942-c573b8ee6ecc', N'd257cf93-e3e1-4ac4-8630-0cef055d0eb9', N'384c9d3f-da23-4107-afbe-08de2e5de8a7', N'37500367-d35f-40cb-aaec-84c82869adf4', CAST(N'2024-10-14' AS Date), N'Level 6', 60, N'Smooth storyteller', CAST(N'2025-11-28T09:10:36.6557488' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'58a31338-2c91-48c5-9f15-d04057560194', N'6fa2f339-fae1-4d86-b311-ade8cf6ba208', N'c374d224-0e43-4026-afbb-08de2e5de8a7', N'74827977-5773-4cd2-824e-ce307d818043', CAST(N'2024-09-30' AS Date), N'Level 5', 50, N'Great summarizing', CAST(N'2025-11-28T09:10:36.6557433' AS DateTime2), NULL)
GO
INSERT [dbo].[ReportCaches] ([Id], [ReportType], [ScopeId], [PeriodStart], [PeriodEnd], [PayloadJson], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'02b28436-624a-4a24-9bad-0fb9bc5f8a0c', N'Dashboard', NULL, CAST(N'2025-11-30' AS Date), CAST(N'2025-11-30' AS Date), N'{"TotalStudents":17,"ActiveStudents":17,"TotalReadingRecords":15,"TotalReadingMinutes":750,"CurrentTermMinutes":0,"ReadingLevelDistribution":{"Level 5":3,"Level 3":2,"Level 4":4,"Level 2":2,"Level 1":1,"Level 6":3},"ClassSummaries":[{"ClassId":"94a5ce45-c184-4f87-946a-26ee5748f564","ClassName":"Class 4A","StudentCount":1,"RecordCount":1,"TotalMinutes":65,"AverageReadingLevel":"Level 5"},{"ClassId":"4db36147-0d00-4b9f-b01e-38c4961d75ae","ClassName":"Class 1C","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"f8b49fc6-a76e-41ca-a6b4-3f7ec1dcb066","ClassName":"Class 2A","StudentCount":2,"RecordCount":2,"TotalMinutes":100,"AverageReadingLevel":"Level 3"},{"ClassId":"00ed7ef1-1d0e-4b6a-ba2a-40b8f298f85e","ClassName":"Class 3C","StudentCount":1,"RecordCount":1,"TotalMinutes":55,"AverageReadingLevel":"Level 4"},{"ClassId":"3287c77f-ff24-41d1-a690-53d92b9f9886","ClassName":"Class 1B","StudentCount":2,"RecordCount":2,"TotalMinutes":85,"AverageReadingLevel":"Level 3"},{"ClassId":"0bef3ada-1789-4645-91d7-6edb181c0ea8","ClassName":"Class 3B","StudentCount":1,"RecordCount":1,"TotalMinutes":40,"AverageReadingLevel":"Level 4"},{"ClassId":"7a517fc2-fa10-4f81-b40a-7f06a2d60e8f","ClassName":"Class 5C","StudentCount":1,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"53474655-3e11-402c-b8b4-87a16e9690f5","ClassName":"Class 5B","StudentCount":1,"RecordCount":1,"TotalMinutes":50,"AverageReadingLevel":"Level 6"},{"ClassId":"b78f7a58-f0ef-4e53-9d89-96b928fc0dca","ClassName":"Class 1A","StudentCount":3,"RecordCount":2,"TotalMinutes":75,"AverageReadingLevel":"Level 1"},{"ClassId":"c9e40b76-7b24-49ff-aa81-97f30c7a77bd","ClassName":"Class 4C","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"fe7e599e-93aa-4389-81ea-9b5757ff79ac","ClassName":"Class 2C","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"a8d7cd5c-43e7-456d-ac85-b60a2eb090b2","ClassName":"Class 4B","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"ad2587c4-83dc-47ba-a78d-c9f5cd7b558a","ClassName":"Class 5A","StudentCount":1,"RecordCount":1,"TotalMinutes":60,"AverageReadingLevel":"Level 6"},{"ClassId":"c6f967eb-12a6-4e39-88c5-dbdc76d0c2ab","ClassName":"Class 3A","StudentCount":2,"RecordCount":2,"TotalMinutes":120,"AverageReadingLevel":"Level 6"},{"ClassId":"7b0047d6-01ee-472d-88ec-f99b507d8f24","ClassName":"Class 2B","StudentCount":2,"RecordCount":2,"TotalMinutes":100,"AverageReadingLevel":"Level 4"}],"MissingEntries":[{"StudentId":"d257cf93-e3e1-4ac4-8630-0cef055d0eb9","StudentName":"Dana Al-Naimi","ClassName":"Class 5A","WeekStart":"2025-11-24"},{"StudentId":"510b3779-683d-4e54-b7fa-1e0ed43f5c08","StudentName":"Hiba Al-Jabri","ClassName":"Class 3C","WeekStart":"2025-11-24"},{"StudentId":"f91496c3-8833-430d-bb7e-216c957318f7","StudentName":"Sara Al-Mousa","ClassName":"Class 1B","WeekStart":"2025-11-24"},{"StudentId":"c70a4b84-2c8e-4d71-972c-25f9bb5bc614","StudentName":"Faizan Arshad","ClassName":"Class 5C","WeekStart":"2025-11-24"},{"StudentId":"5143f723-867e-421b-bd84-2fd28780d8ce","StudentName":"Mohammed Al-Hajri","ClassName":"Class 1B","WeekStart":"2025-11-24"},{"StudentId":"f045cc26-40e5-4521-ac57-508fd52ee8bb","StudentName":"Omar Al-Khayyat","ClassName":"Class 3A","WeekStart":"2025-11-24"},{"StudentId":"5a846331-d547-40c8-8c5e-727e7c306c87","StudentName":"Ali Al-Hasan","ClassName":"Class 2A","WeekStart":"2025-11-24"},{"StudentId":"0d1dfd76-6235-48be-9dfc-7fc43ce1ff98","StudentName":"Hamad Al-Kaabi","ClassName":"Class 2B","WeekStart":"2025-11-24"},{"StudentId":"6fa2f339-fae1-4d86-b311-ade8cf6ba208","StudentName":"Layla Abdullah","ClassName":"Class 3A","WeekStart":"2025-11-24"},{"StudentId":"00e89d8a-42a0-4d6a-94ca-b8e6028c9174","StudentName":"Rakan Al-Mutlaq","ClassName":"Class 5B","WeekStart":"2025-11-24"},{"StudentId":"4c9625ac-e200-4775-988c-cb482860776f","StudentName":"Sami Al-Qattan","ClassName":"Class 4A","WeekStart":"2025-11-24"},{"StudentId":"97df50af-98bb-46e6-b552-cc0eee41ee49","StudentName":"Yassin Al-Saffar","ClassName":"Class 3B","WeekStart":"2025-11-24"},{"StudentId":"87503a49-920f-4ee4-8a56-d9e21a833d75","StudentName":"Maryam Al-Awadi","ClassName":"Class 2B","WeekStart":"2025-11-24"},{"StudentId":"eb9de0d1-0c98-4721-b238-daea3d36fca7","StudentName":"Ahmad Al-Hammadi","ClassName":"Class 1A","WeekStart":"2025-11-24"},{"StudentId":"3b4ea0ed-ef7e-4ebc-931c-e87a79206672","StudentName":"Zainab Zainab","ClassName":"Class 1A","WeekStart":"2025-11-24"},{"StudentId":"3c67eed7-9aa0-40ac-b882-ec56e62c483d","StudentName":"Noura Al-Subaie","ClassName":"Class 2A","WeekStart":"2025-11-24"},{"StudentId":"233c10c4-a0d6-4c63-8640-f3ef53a1480b","StudentName":"Fatimah Al-Khalifa","ClassName":"Class 1A","WeekStart":"2025-11-24"}]}', CAST(N'2025-11-30T11:29:54.4062911' AS DateTime2), NULL)
GO
INSERT [dbo].[ReportCaches] ([Id], [ReportType], [ScopeId], [PeriodStart], [PeriodEnd], [PayloadJson], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'ac07f134-8c57-4025-a0ce-2cff1c6cb0da', N'Dashboard', NULL, CAST(N'2025-11-28' AS Date), CAST(N'2025-11-28' AS Date), N'{"TotalStudents":17,"ActiveStudents":17,"TotalReadingRecords":15,"TotalReadingMinutes":750,"CurrentTermMinutes":0,"ReadingLevelDistribution":{"Level 5":3,"Level 3":2,"Level 4":4,"Level 2":2,"Level 1":1,"Level 6":3},"ClassSummaries":[{"ClassId":"94a5ce45-c184-4f87-946a-26ee5748f564","ClassName":"Class 4A","StudentCount":1,"RecordCount":1,"TotalMinutes":65,"AverageReadingLevel":"Level 5"},{"ClassId":"4db36147-0d00-4b9f-b01e-38c4961d75ae","ClassName":"Class 1C","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"f8b49fc6-a76e-41ca-a6b4-3f7ec1dcb066","ClassName":"Class 2A","StudentCount":2,"RecordCount":2,"TotalMinutes":100,"AverageReadingLevel":"Level 3"},{"ClassId":"00ed7ef1-1d0e-4b6a-ba2a-40b8f298f85e","ClassName":"Class 3C","StudentCount":1,"RecordCount":1,"TotalMinutes":55,"AverageReadingLevel":"Level 4"},{"ClassId":"3287c77f-ff24-41d1-a690-53d92b9f9886","ClassName":"Class 1B","StudentCount":2,"RecordCount":2,"TotalMinutes":85,"AverageReadingLevel":"Level 3"},{"ClassId":"0bef3ada-1789-4645-91d7-6edb181c0ea8","ClassName":"Class 3B","StudentCount":1,"RecordCount":1,"TotalMinutes":40,"AverageReadingLevel":"Level 4"},{"ClassId":"7a517fc2-fa10-4f81-b40a-7f06a2d60e8f","ClassName":"Class 5C","StudentCount":1,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"53474655-3e11-402c-b8b4-87a16e9690f5","ClassName":"Class 5B","StudentCount":1,"RecordCount":1,"TotalMinutes":50,"AverageReadingLevel":"Level 6"},{"ClassId":"b78f7a58-f0ef-4e53-9d89-96b928fc0dca","ClassName":"Class 1A","StudentCount":3,"RecordCount":2,"TotalMinutes":75,"AverageReadingLevel":"Level 1"},{"ClassId":"c9e40b76-7b24-49ff-aa81-97f30c7a77bd","ClassName":"Class 4C","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"fe7e599e-93aa-4389-81ea-9b5757ff79ac","ClassName":"Class 2C","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"a8d7cd5c-43e7-456d-ac85-b60a2eb090b2","ClassName":"Class 4B","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"ad2587c4-83dc-47ba-a78d-c9f5cd7b558a","ClassName":"Class 5A","StudentCount":1,"RecordCount":1,"TotalMinutes":60,"AverageReadingLevel":"Level 6"},{"ClassId":"c6f967eb-12a6-4e39-88c5-dbdc76d0c2ab","ClassName":"Class 3A","StudentCount":2,"RecordCount":2,"TotalMinutes":120,"AverageReadingLevel":"Level 6"},{"ClassId":"7b0047d6-01ee-472d-88ec-f99b507d8f24","ClassName":"Class 2B","StudentCount":2,"RecordCount":2,"TotalMinutes":100,"AverageReadingLevel":"Level 4"}],"MissingEntries":[{"StudentId":"d257cf93-e3e1-4ac4-8630-0cef055d0eb9","StudentName":"Dana Al-Naimi","ClassName":"Class 5A","WeekStart":"2025-11-24"},{"StudentId":"510b3779-683d-4e54-b7fa-1e0ed43f5c08","StudentName":"Hiba Al-Jabri","ClassName":"Class 3C","WeekStart":"2025-11-24"},{"StudentId":"f91496c3-8833-430d-bb7e-216c957318f7","StudentName":"Sara Al-Mousa","ClassName":"Class 1B","WeekStart":"2025-11-24"},{"StudentId":"c70a4b84-2c8e-4d71-972c-25f9bb5bc614","StudentName":"Faizan Arshad","ClassName":"Class 5C","WeekStart":"2025-11-24"},{"StudentId":"5143f723-867e-421b-bd84-2fd28780d8ce","StudentName":"Mohammed Al-Hajri","ClassName":"Class 1B","WeekStart":"2025-11-24"},{"StudentId":"f045cc26-40e5-4521-ac57-508fd52ee8bb","StudentName":"Omar Al-Khayyat","ClassName":"Class 3A","WeekStart":"2025-11-24"},{"StudentId":"5a846331-d547-40c8-8c5e-727e7c306c87","StudentName":"Ali Al-Hasan","ClassName":"Class 2A","WeekStart":"2025-11-24"},{"StudentId":"0d1dfd76-6235-48be-9dfc-7fc43ce1ff98","StudentName":"Hamad Al-Kaabi","ClassName":"Class 2B","WeekStart":"2025-11-24"},{"StudentId":"6fa2f339-fae1-4d86-b311-ade8cf6ba208","StudentName":"Layla Abdullah","ClassName":"Class 3A","WeekStart":"2025-11-24"},{"StudentId":"00e89d8a-42a0-4d6a-94ca-b8e6028c9174","StudentName":"Rakan Al-Mutlaq","ClassName":"Class 5B","WeekStart":"2025-11-24"},{"StudentId":"4c9625ac-e200-4775-988c-cb482860776f","StudentName":"Sami Al-Qattan","ClassName":"Class 4A","WeekStart":"2025-11-24"},{"StudentId":"97df50af-98bb-46e6-b552-cc0eee41ee49","StudentName":"Yassin Al-Saffar","ClassName":"Class 3B","WeekStart":"2025-11-24"},{"StudentId":"87503a49-920f-4ee4-8a56-d9e21a833d75","StudentName":"Maryam Al-Awadi","ClassName":"Class 2B","WeekStart":"2025-11-24"},{"StudentId":"eb9de0d1-0c98-4721-b238-daea3d36fca7","StudentName":"Ahmad Al-Hammadi","ClassName":"Class 1A","WeekStart":"2025-11-24"},{"StudentId":"3b4ea0ed-ef7e-4ebc-931c-e87a79206672","StudentName":"Zainab Zainab","ClassName":"Class 1A","WeekStart":"2025-11-24"},{"StudentId":"3c67eed7-9aa0-40ac-b882-ec56e62c483d","StudentName":"Noura Al-Subaie","ClassName":"Class 2A","WeekStart":"2025-11-24"},{"StudentId":"233c10c4-a0d6-4c63-8640-f3ef53a1480b","StudentName":"Fatimah Al-Khalifa","ClassName":"Class 1A","WeekStart":"2025-11-24"}]}', CAST(N'2025-11-28T12:09:11.9904993' AS DateTime2), NULL)
GO
INSERT [dbo].[ReportCaches] ([Id], [ReportType], [ScopeId], [PeriodStart], [PeriodEnd], [PayloadJson], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'56079aa2-1846-48c3-82d0-4a4e2a2f8c2d', N'Dashboard', NULL, CAST(N'2025-11-29' AS Date), CAST(N'2025-11-29' AS Date), N'{"TotalStudents":17,"ActiveStudents":17,"TotalReadingRecords":15,"TotalReadingMinutes":750,"CurrentTermMinutes":0,"ReadingLevelDistribution":{"Level 5":3,"Level 3":2,"Level 4":4,"Level 2":2,"Level 1":1,"Level 6":3},"ClassSummaries":[{"ClassId":"94a5ce45-c184-4f87-946a-26ee5748f564","ClassName":"Class 4A","StudentCount":1,"RecordCount":1,"TotalMinutes":65,"AverageReadingLevel":"Level 5"},{"ClassId":"4db36147-0d00-4b9f-b01e-38c4961d75ae","ClassName":"Class 1C","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"f8b49fc6-a76e-41ca-a6b4-3f7ec1dcb066","ClassName":"Class 2A","StudentCount":2,"RecordCount":2,"TotalMinutes":100,"AverageReadingLevel":"Level 3"},{"ClassId":"00ed7ef1-1d0e-4b6a-ba2a-40b8f298f85e","ClassName":"Class 3C","StudentCount":1,"RecordCount":1,"TotalMinutes":55,"AverageReadingLevel":"Level 4"},{"ClassId":"3287c77f-ff24-41d1-a690-53d92b9f9886","ClassName":"Class 1B","StudentCount":2,"RecordCount":2,"TotalMinutes":85,"AverageReadingLevel":"Level 3"},{"ClassId":"0bef3ada-1789-4645-91d7-6edb181c0ea8","ClassName":"Class 3B","StudentCount":1,"RecordCount":1,"TotalMinutes":40,"AverageReadingLevel":"Level 4"},{"ClassId":"7a517fc2-fa10-4f81-b40a-7f06a2d60e8f","ClassName":"Class 5C","StudentCount":1,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"53474655-3e11-402c-b8b4-87a16e9690f5","ClassName":"Class 5B","StudentCount":1,"RecordCount":1,"TotalMinutes":50,"AverageReadingLevel":"Level 6"},{"ClassId":"b78f7a58-f0ef-4e53-9d89-96b928fc0dca","ClassName":"Class 1A","StudentCount":3,"RecordCount":2,"TotalMinutes":75,"AverageReadingLevel":"Level 1"},{"ClassId":"c9e40b76-7b24-49ff-aa81-97f30c7a77bd","ClassName":"Class 4C","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"fe7e599e-93aa-4389-81ea-9b5757ff79ac","ClassName":"Class 2C","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"a8d7cd5c-43e7-456d-ac85-b60a2eb090b2","ClassName":"Class 4B","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"ad2587c4-83dc-47ba-a78d-c9f5cd7b558a","ClassName":"Class 5A","StudentCount":1,"RecordCount":1,"TotalMinutes":60,"AverageReadingLevel":"Level 6"},{"ClassId":"c6f967eb-12a6-4e39-88c5-dbdc76d0c2ab","ClassName":"Class 3A","StudentCount":2,"RecordCount":2,"TotalMinutes":120,"AverageReadingLevel":"Level 6"},{"ClassId":"7b0047d6-01ee-472d-88ec-f99b507d8f24","ClassName":"Class 2B","StudentCount":2,"RecordCount":2,"TotalMinutes":100,"AverageReadingLevel":"Level 4"}],"MissingEntries":[{"StudentId":"d257cf93-e3e1-4ac4-8630-0cef055d0eb9","StudentName":"Dana Al-Naimi","ClassName":"Class 5A","WeekStart":"2025-11-24"},{"StudentId":"510b3779-683d-4e54-b7fa-1e0ed43f5c08","StudentName":"Hiba Al-Jabri","ClassName":"Class 3C","WeekStart":"2025-11-24"},{"StudentId":"f91496c3-8833-430d-bb7e-216c957318f7","StudentName":"Sara Al-Mousa","ClassName":"Class 1B","WeekStart":"2025-11-24"},{"StudentId":"c70a4b84-2c8e-4d71-972c-25f9bb5bc614","StudentName":"Faizan Arshad","ClassName":"Class 5C","WeekStart":"2025-11-24"},{"StudentId":"5143f723-867e-421b-bd84-2fd28780d8ce","StudentName":"Mohammed Al-Hajri","ClassName":"Class 1B","WeekStart":"2025-11-24"},{"StudentId":"f045cc26-40e5-4521-ac57-508fd52ee8bb","StudentName":"Omar Al-Khayyat","ClassName":"Class 3A","WeekStart":"2025-11-24"},{"StudentId":"5a846331-d547-40c8-8c5e-727e7c306c87","StudentName":"Ali Al-Hasan","ClassName":"Class 2A","WeekStart":"2025-11-24"},{"StudentId":"0d1dfd76-6235-48be-9dfc-7fc43ce1ff98","StudentName":"Hamad Al-Kaabi","ClassName":"Class 2B","WeekStart":"2025-11-24"},{"StudentId":"6fa2f339-fae1-4d86-b311-ade8cf6ba208","StudentName":"Layla Abdullah","ClassName":"Class 3A","WeekStart":"2025-11-24"},{"StudentId":"00e89d8a-42a0-4d6a-94ca-b8e6028c9174","StudentName":"Rakan Al-Mutlaq","ClassName":"Class 5B","WeekStart":"2025-11-24"},{"StudentId":"4c9625ac-e200-4775-988c-cb482860776f","StudentName":"Sami Al-Qattan","ClassName":"Class 4A","WeekStart":"2025-11-24"},{"StudentId":"97df50af-98bb-46e6-b552-cc0eee41ee49","StudentName":"Yassin Al-Saffar","ClassName":"Class 3B","WeekStart":"2025-11-24"},{"StudentId":"87503a49-920f-4ee4-8a56-d9e21a833d75","StudentName":"Maryam Al-Awadi","ClassName":"Class 2B","WeekStart":"2025-11-24"},{"StudentId":"eb9de0d1-0c98-4721-b238-daea3d36fca7","StudentName":"Ahmad Al-Hammadi","ClassName":"Class 1A","WeekStart":"2025-11-24"},{"StudentId":"3b4ea0ed-ef7e-4ebc-931c-e87a79206672","StudentName":"Zainab Zainab","ClassName":"Class 1A","WeekStart":"2025-11-24"},{"StudentId":"3c67eed7-9aa0-40ac-b882-ec56e62c483d","StudentName":"Noura Al-Subaie","ClassName":"Class 2A","WeekStart":"2025-11-24"},{"StudentId":"233c10c4-a0d6-4c63-8640-f3ef53a1480b","StudentName":"Fatimah Al-Khalifa","ClassName":"Class 1A","WeekStart":"2025-11-24"}]}', CAST(N'2025-11-29T12:39:18.7485895' AS DateTime2), NULL)
GO
INSERT [dbo].[ReportCaches] ([Id], [ReportType], [ScopeId], [PeriodStart], [PeriodEnd], [PayloadJson], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'46f90ffd-a6c8-4de3-ad29-81d954b7b3a3', N'Dashboard', NULL, CAST(N'2025-11-29' AS Date), CAST(N'2025-11-29' AS Date), N'{"TotalStudents":17,"ActiveStudents":17,"TotalReadingRecords":15,"TotalReadingMinutes":750,"CurrentTermMinutes":0,"ReadingLevelDistribution":{"Level 5":3,"Level 3":2,"Level 4":4,"Level 2":2,"Level 1":1,"Level 6":3},"ClassSummaries":[{"ClassId":"94a5ce45-c184-4f87-946a-26ee5748f564","ClassName":"Class 4A","StudentCount":1,"RecordCount":1,"TotalMinutes":65,"AverageReadingLevel":"Level 5"},{"ClassId":"4db36147-0d00-4b9f-b01e-38c4961d75ae","ClassName":"Class 1C","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"f8b49fc6-a76e-41ca-a6b4-3f7ec1dcb066","ClassName":"Class 2A","StudentCount":2,"RecordCount":2,"TotalMinutes":100,"AverageReadingLevel":"Level 3"},{"ClassId":"00ed7ef1-1d0e-4b6a-ba2a-40b8f298f85e","ClassName":"Class 3C","StudentCount":1,"RecordCount":1,"TotalMinutes":55,"AverageReadingLevel":"Level 4"},{"ClassId":"3287c77f-ff24-41d1-a690-53d92b9f9886","ClassName":"Class 1B","StudentCount":2,"RecordCount":2,"TotalMinutes":85,"AverageReadingLevel":"Level 3"},{"ClassId":"0bef3ada-1789-4645-91d7-6edb181c0ea8","ClassName":"Class 3B","StudentCount":1,"RecordCount":1,"TotalMinutes":40,"AverageReadingLevel":"Level 4"},{"ClassId":"7a517fc2-fa10-4f81-b40a-7f06a2d60e8f","ClassName":"Class 5C","StudentCount":1,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"53474655-3e11-402c-b8b4-87a16e9690f5","ClassName":"Class 5B","StudentCount":1,"RecordCount":1,"TotalMinutes":50,"AverageReadingLevel":"Level 6"},{"ClassId":"b78f7a58-f0ef-4e53-9d89-96b928fc0dca","ClassName":"Class 1A","StudentCount":3,"RecordCount":2,"TotalMinutes":75,"AverageReadingLevel":"Level 1"},{"ClassId":"c9e40b76-7b24-49ff-aa81-97f30c7a77bd","ClassName":"Class 4C","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"fe7e599e-93aa-4389-81ea-9b5757ff79ac","ClassName":"Class 2C","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"a8d7cd5c-43e7-456d-ac85-b60a2eb090b2","ClassName":"Class 4B","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"ad2587c4-83dc-47ba-a78d-c9f5cd7b558a","ClassName":"Class 5A","StudentCount":1,"RecordCount":1,"TotalMinutes":60,"AverageReadingLevel":"Level 6"},{"ClassId":"c6f967eb-12a6-4e39-88c5-dbdc76d0c2ab","ClassName":"Class 3A","StudentCount":2,"RecordCount":2,"TotalMinutes":120,"AverageReadingLevel":"Level 6"},{"ClassId":"7b0047d6-01ee-472d-88ec-f99b507d8f24","ClassName":"Class 2B","StudentCount":2,"RecordCount":2,"TotalMinutes":100,"AverageReadingLevel":"Level 4"}],"MissingEntries":[{"StudentId":"d257cf93-e3e1-4ac4-8630-0cef055d0eb9","StudentName":"Dana Al-Naimi","ClassName":"Class 5A","WeekStart":"2025-11-24"},{"StudentId":"510b3779-683d-4e54-b7fa-1e0ed43f5c08","StudentName":"Hiba Al-Jabri","ClassName":"Class 3C","WeekStart":"2025-11-24"},{"StudentId":"f91496c3-8833-430d-bb7e-216c957318f7","StudentName":"Sara Al-Mousa","ClassName":"Class 1B","WeekStart":"2025-11-24"},{"StudentId":"c70a4b84-2c8e-4d71-972c-25f9bb5bc614","StudentName":"Faizan Arshad","ClassName":"Class 5C","WeekStart":"2025-11-24"},{"StudentId":"5143f723-867e-421b-bd84-2fd28780d8ce","StudentName":"Mohammed Al-Hajri","ClassName":"Class 1B","WeekStart":"2025-11-24"},{"StudentId":"f045cc26-40e5-4521-ac57-508fd52ee8bb","StudentName":"Omar Al-Khayyat","ClassName":"Class 3A","WeekStart":"2025-11-24"},{"StudentId":"5a846331-d547-40c8-8c5e-727e7c306c87","StudentName":"Ali Al-Hasan","ClassName":"Class 2A","WeekStart":"2025-11-24"},{"StudentId":"0d1dfd76-6235-48be-9dfc-7fc43ce1ff98","StudentName":"Hamad Al-Kaabi","ClassName":"Class 2B","WeekStart":"2025-11-24"},{"StudentId":"6fa2f339-fae1-4d86-b311-ade8cf6ba208","StudentName":"Layla Abdullah","ClassName":"Class 3A","WeekStart":"2025-11-24"},{"StudentId":"00e89d8a-42a0-4d6a-94ca-b8e6028c9174","StudentName":"Rakan Al-Mutlaq","ClassName":"Class 5B","WeekStart":"2025-11-24"},{"StudentId":"4c9625ac-e200-4775-988c-cb482860776f","StudentName":"Sami Al-Qattan","ClassName":"Class 4A","WeekStart":"2025-11-24"},{"StudentId":"97df50af-98bb-46e6-b552-cc0eee41ee49","StudentName":"Yassin Al-Saffar","ClassName":"Class 3B","WeekStart":"2025-11-24"},{"StudentId":"87503a49-920f-4ee4-8a56-d9e21a833d75","StudentName":"Maryam Al-Awadi","ClassName":"Class 2B","WeekStart":"2025-11-24"},{"StudentId":"eb9de0d1-0c98-4721-b238-daea3d36fca7","StudentName":"Ahmad Al-Hammadi","ClassName":"Class 1A","WeekStart":"2025-11-24"},{"StudentId":"3b4ea0ed-ef7e-4ebc-931c-e87a79206672","StudentName":"Zainab Zainab","ClassName":"Class 1A","WeekStart":"2025-11-24"},{"StudentId":"3c67eed7-9aa0-40ac-b882-ec56e62c483d","StudentName":"Noura Al-Subaie","ClassName":"Class 2A","WeekStart":"2025-11-24"},{"StudentId":"233c10c4-a0d6-4c63-8640-f3ef53a1480b","StudentName":"Fatimah Al-Khalifa","ClassName":"Class 1A","WeekStart":"2025-11-24"}]}', CAST(N'2025-11-29T23:42:28.8418379' AS DateTime2), NULL)
GO
INSERT [dbo].[ReportCaches] ([Id], [ReportType], [ScopeId], [PeriodStart], [PeriodEnd], [PayloadJson], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'60148e2d-17cf-4042-bcc8-9f98f513e46a', N'Dashboard', NULL, CAST(N'2025-11-28' AS Date), CAST(N'2025-11-28' AS Date), N'{"TotalStudents":15,"ActiveStudents":15,"TotalReadingRecords":15,"TotalReadingMinutes":750,"CurrentTermMinutes":0,"ReadingLevelDistribution":{"Level 5":3,"Level 3":2,"Level 4":4,"Level 2":2,"Level 1":1,"Level 6":3},"ClassSummaries":[{"ClassId":"94a5ce45-c184-4f87-946a-26ee5748f564","ClassName":"Class 4A","StudentCount":1,"RecordCount":1,"TotalMinutes":65,"AverageReadingLevel":"Level 5"},{"ClassId":"4db36147-0d00-4b9f-b01e-38c4961d75ae","ClassName":"Class 1C","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"f8b49fc6-a76e-41ca-a6b4-3f7ec1dcb066","ClassName":"Class 2A","StudentCount":2,"RecordCount":2,"TotalMinutes":100,"AverageReadingLevel":"Level 3"},{"ClassId":"00ed7ef1-1d0e-4b6a-ba2a-40b8f298f85e","ClassName":"Class 3C","StudentCount":1,"RecordCount":1,"TotalMinutes":55,"AverageReadingLevel":"Level 4"},{"ClassId":"3287c77f-ff24-41d1-a690-53d92b9f9886","ClassName":"Class 1B","StudentCount":2,"RecordCount":2,"TotalMinutes":85,"AverageReadingLevel":"Level 3"},{"ClassId":"0bef3ada-1789-4645-91d7-6edb181c0ea8","ClassName":"Class 3B","StudentCount":1,"RecordCount":1,"TotalMinutes":40,"AverageReadingLevel":"Level 4"},{"ClassId":"7a517fc2-fa10-4f81-b40a-7f06a2d60e8f","ClassName":"Class 5C","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"53474655-3e11-402c-b8b4-87a16e9690f5","ClassName":"Class 5B","StudentCount":1,"RecordCount":1,"TotalMinutes":50,"AverageReadingLevel":"Level 6"},{"ClassId":"b78f7a58-f0ef-4e53-9d89-96b928fc0dca","ClassName":"Class 1A","StudentCount":2,"RecordCount":2,"TotalMinutes":75,"AverageReadingLevel":"Level 1"},{"ClassId":"c9e40b76-7b24-49ff-aa81-97f30c7a77bd","ClassName":"Class 4C","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"fe7e599e-93aa-4389-81ea-9b5757ff79ac","ClassName":"Class 2C","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"a8d7cd5c-43e7-456d-ac85-b60a2eb090b2","ClassName":"Class 4B","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"ad2587c4-83dc-47ba-a78d-c9f5cd7b558a","ClassName":"Class 5A","StudentCount":1,"RecordCount":1,"TotalMinutes":60,"AverageReadingLevel":"Level 6"},{"ClassId":"c6f967eb-12a6-4e39-88c5-dbdc76d0c2ab","ClassName":"Class 3A","StudentCount":2,"RecordCount":2,"TotalMinutes":120,"AverageReadingLevel":"Level 6"},{"ClassId":"7b0047d6-01ee-472d-88ec-f99b507d8f24","ClassName":"Class 2B","StudentCount":2,"RecordCount":2,"TotalMinutes":100,"AverageReadingLevel":"Level 4"}],"MissingEntries":[{"StudentId":"d257cf93-e3e1-4ac4-8630-0cef055d0eb9","StudentName":"Dana Al-Naimi","ClassName":"Class 5A","WeekStart":"2025-11-24"},{"StudentId":"510b3779-683d-4e54-b7fa-1e0ed43f5c08","StudentName":"Hiba Al-Jabri","ClassName":"Class 3C","WeekStart":"2025-11-24"},{"StudentId":"f91496c3-8833-430d-bb7e-216c957318f7","StudentName":"Sara Al-Mousa","ClassName":"Class 1B","WeekStart":"2025-11-24"},{"StudentId":"5143f723-867e-421b-bd84-2fd28780d8ce","StudentName":"Mohammed Al-Hajri","ClassName":"Class 1B","WeekStart":"2025-11-24"},{"StudentId":"f045cc26-40e5-4521-ac57-508fd52ee8bb","StudentName":"Omar Al-Khayyat","ClassName":"Class 3A","WeekStart":"2025-11-24"},{"StudentId":"5a846331-d547-40c8-8c5e-727e7c306c87","StudentName":"Ali Al-Hasan","ClassName":"Class 2A","WeekStart":"2025-11-24"},{"StudentId":"0d1dfd76-6235-48be-9dfc-7fc43ce1ff98","StudentName":"Hamad Al-Kaabi","ClassName":"Class 2B","WeekStart":"2025-11-24"},{"StudentId":"6fa2f339-fae1-4d86-b311-ade8cf6ba208","StudentName":"Layla Abdullah","ClassName":"Class 3A","WeekStart":"2025-11-24"},{"StudentId":"00e89d8a-42a0-4d6a-94ca-b8e6028c9174","StudentName":"Rakan Al-Mutlaq","ClassName":"Class 5B","WeekStart":"2025-11-24"},{"StudentId":"4c9625ac-e200-4775-988c-cb482860776f","StudentName":"Sami Al-Qattan","ClassName":"Class 4A","WeekStart":"2025-11-24"},{"StudentId":"97df50af-98bb-46e6-b552-cc0eee41ee49","StudentName":"Yassin Al-Saffar","ClassName":"Class 3B","WeekStart":"2025-11-24"},{"StudentId":"87503a49-920f-4ee4-8a56-d9e21a833d75","StudentName":"Maryam Al-Awadi","ClassName":"Class 2B","WeekStart":"2025-11-24"},{"StudentId":"eb9de0d1-0c98-4721-b238-daea3d36fca7","StudentName":"Ahmad Al-Hammadi","ClassName":"Class 1A","WeekStart":"2025-11-24"},{"StudentId":"3c67eed7-9aa0-40ac-b882-ec56e62c483d","StudentName":"Noura Al-Subaie","ClassName":"Class 2A","WeekStart":"2025-11-24"},{"StudentId":"233c10c4-a0d6-4c63-8640-f3ef53a1480b","StudentName":"Fatimah Al-Khalifa","ClassName":"Class 1A","WeekStart":"2025-11-24"}]}', CAST(N'2025-11-28T09:12:40.6109200' AS DateTime2), NULL)
GO
INSERT [dbo].[ReportCaches] ([Id], [ReportType], [ScopeId], [PeriodStart], [PeriodEnd], [PayloadJson], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'ba97b840-d270-4a53-89b8-dccbc228613a', N'Dashboard', N'b0e95f85-ebe8-42c0-8b67-813e292b571f', CAST(N'2025-11-28' AS Date), CAST(N'2025-11-28' AS Date), N'{"TotalStudents":4,"TotalReadingRecords":4,"TotalReadingMinutes":175,"ClassSummaries":[{"ClassId":"4db36147-0d00-4b9f-b01e-38c4961d75ae","ClassName":"Class 1C","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"b78f7a58-f0ef-4e53-9d89-96b928fc0dca","ClassName":"Class 1A","StudentCount":2,"RecordCount":2,"TotalMinutes":75,"AverageReadingLevel":"Level 1"},{"ClassId":"7b0047d6-01ee-472d-88ec-f99b507d8f24","ClassName":"Class 2B","StudentCount":2,"RecordCount":2,"TotalMinutes":100,"AverageReadingLevel":"Level 4"}],"MissingEntries":[{"StudentId":"0d1dfd76-6235-48be-9dfc-7fc43ce1ff98","StudentName":"Hamad Al-Kaabi","ClassName":"Class 2B","WeekStart":"2025-11-24"},{"StudentId":"87503a49-920f-4ee4-8a56-d9e21a833d75","StudentName":"Maryam Al-Awadi","ClassName":"Class 2B","WeekStart":"2025-11-24"},{"StudentId":"eb9de0d1-0c98-4721-b238-daea3d36fca7","StudentName":"Ahmad Al-Hammadi","ClassName":"Class 1A","WeekStart":"2025-11-24"},{"StudentId":"233c10c4-a0d6-4c63-8640-f3ef53a1480b","StudentName":"Fatimah Al-Khalifa","ClassName":"Class 1A","WeekStart":"2025-11-24"}],"StudentLastReadings":[{"StudentId":"eb9de0d1-0c98-4721-b238-daea3d36fca7","StudentName":"Ahmad Al-Hammadi","ClassName":"Class 1A","LastReadingLevel":"Level 2","LastReadingDate":"2024-09-02"},{"StudentId":"233c10c4-a0d6-4c63-8640-f3ef53a1480b","StudentName":"Fatimah Al-Khalifa","ClassName":"Class 1A","LastReadingLevel":"Level 1","LastReadingDate":"2024-09-02"},{"StudentId":"0d1dfd76-6235-48be-9dfc-7fc43ce1ff98","StudentName":"Hamad Al-Kaabi","ClassName":"Class 2B","LastReadingLevel":"Level 5","LastReadingDate":"2024-09-23"},{"StudentId":"87503a49-920f-4ee4-8a56-d9e21a833d75","StudentName":"Maryam Al-Awadi","ClassName":"Class 2B","LastReadingLevel":"Level 4","LastReadingDate":"2024-09-23"}]}', CAST(N'2025-11-28T09:15:40.8781087' AS DateTime2), NULL)
GO
INSERT [dbo].[Roles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'2aca228c-666c-424f-c356-08de2e5de745', N'Coordinator', N'COORDINATOR', NULL)
GO
INSERT [dbo].[Roles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'2af6540c-5cb5-4b10-c357-08de2e5de745', N'Teacher', N'TEACHER', NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'd257cf93-e3e1-4ac4-8630-0cef055d0eb9', N'ST014', N'Dana', N'Al-Naimi', N'Female', CAST(N'2007-10-07T00:00:00.0000000' AS DateTime2), N'ad2587c4-83dc-47ba-a78d-c9f5cd7b558a', N'Level 6', N'Active', CAST(N'2025-11-28T09:10:34.1567069' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'510b3779-683d-4e54-b7fa-1e0ed43f5c08', N'ST012', N'Hiba', N'Al-Jabri', N'Female', CAST(N'2008-06-27T00:00:00.0000000' AS DateTime2), N'00ed7ef1-1d0e-4b6a-ba2a-40b8f298f85e', N'Level 4', N'Active', CAST(N'2025-11-28T09:10:34.1567049' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'f91496c3-8833-430d-bb7e-216c957318f7', N'ST004', N'Sara', N'Al-Mousa', N'Female', CAST(N'2010-05-14T00:00:00.0000000' AS DateTime2), N'3287c77f-ff24-41d1-a690-53d92b9f9886', N'Level 2', N'Active', CAST(N'2025-11-28T09:10:34.1566925' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'5143f723-867e-421b-bd84-2fd28780d8ce', N'ST003', N'Mohammed', N'Al-Hajri', N'Male', CAST(N'2009-11-08T00:00:00.0000000' AS DateTime2), N'3287c77f-ff24-41d1-a690-53d92b9f9886', N'Level 3', N'Active', CAST(N'2025-11-28T09:10:34.1566904' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'f045cc26-40e5-4521-ac57-508fd52ee8bb', N'ST009', N'Omar', N'Al-Khayyat', N'Male', CAST(N'2008-10-12T00:00:00.0000000' AS DateTime2), N'c6f967eb-12a6-4e39-88c5-dbdc76d0c2ab', N'Level 6', N'Active', CAST(N'2025-11-28T09:10:34.1566994' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'5a846331-d547-40c8-8c5e-727e7c306c87', N'ST005', N'Ali', N'Al-Hasan', N'Male', CAST(N'2009-09-30T00:00:00.0000000' AS DateTime2), N'f8b49fc6-a76e-41ca-a6b4-3f7ec1dcb066', N'Level 4', N'Active', CAST(N'2025-11-28T09:10:34.1566944' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'0d1dfd76-6235-48be-9dfc-7fc43ce1ff98', N'ST007', N'Hamad', N'Al-Kaabi', N'Male', CAST(N'2009-12-05T00:00:00.0000000' AS DateTime2), N'7b0047d6-01ee-472d-88ec-f99b507d8f24', N'Level 5', N'Active', CAST(N'2025-11-28T09:10:34.1566975' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'6fa2f339-fae1-4d86-b311-ade8cf6ba208', N'ST010', N'Layla', N'Abdullah', N'Female', CAST(N'2008-08-25T00:00:00.0000000' AS DateTime2), N'c6f967eb-12a6-4e39-88c5-dbdc76d0c2ab', N'Level 5', N'Active', CAST(N'2025-11-28T09:10:34.1567003' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'00e89d8a-42a0-4d6a-94ca-b8e6028c9174', N'ST015', N'Rakan', N'Al-Mutlaq', N'Male', CAST(N'2007-05-02T00:00:00.0000000' AS DateTime2), N'53474655-3e11-402c-b8b4-87a16e9690f5', N'Level 6', N'Active', CAST(N'2025-11-28T09:10:34.1567081' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'4c9625ac-e200-4775-988c-cb482860776f', N'ST013', N'Sami', N'Al-Qattan', N'Male', CAST(N'2007-12-19T00:00:00.0000000' AS DateTime2), N'94a5ce45-c184-4f87-946a-26ee5748f564', N'Level 5', N'Active', CAST(N'2025-11-28T09:10:34.1567062' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'97df50af-98bb-46e6-b552-cc0eee41ee49', N'ST011', N'Yassin', N'Al-Saffar', N'Male', CAST(N'2008-03-11T00:00:00.0000000' AS DateTime2), N'0bef3ada-1789-4645-91d7-6edb181c0ea8', N'Level 4', N'Active', CAST(N'2025-11-28T09:10:34.1567026' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'87503a49-920f-4ee4-8a56-d9e21a833d75', N'ST008', N'Maryam', N'Al-Awadi', N'Female', CAST(N'2009-04-20T00:00:00.0000000' AS DateTime2), N'7b0047d6-01ee-472d-88ec-f99b507d8f24', N'Level 4', N'Active', CAST(N'2025-11-28T09:10:34.1566986' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'eb9de0d1-0c98-4721-b238-daea3d36fca7', N'ST001', N'Ahmad', N'Al-Hammadi', N'Male', CAST(N'2010-01-15T00:00:00.0000000' AS DateTime2), N'b78f7a58-f0ef-4e53-9d89-96b928fc0dca', N'Level 2', N'Active', CAST(N'2025-11-28T09:10:34.1543260' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'3b4ea0ed-ef7e-4ebc-931c-e87a79206672', N'ST0017', N'Zainab', N'Zainab', N'Female', CAST(N'2004-05-10T00:00:00.0000000' AS DateTime2), N'b78f7a58-f0ef-4e53-9d89-96b928fc0dca', N'Level 3', N'Active', CAST(N'2025-11-28T09:46:40.7965352' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'3c67eed7-9aa0-40ac-b882-ec56e62c483d', N'ST006', N'Noura', N'Al-Subaie', N'Female', CAST(N'2009-07-18T00:00:00.0000000' AS DateTime2), N'f8b49fc6-a76e-41ca-a6b4-3f7ec1dcb066', N'Level 3', N'Active', CAST(N'2025-11-28T09:10:34.1566958' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'233c10c4-a0d6-4c63-8640-f3ef53a1480b', N'ST002', N'Fatimah', N'Al-Khalifa', N'Female', CAST(N'2010-03-22T00:00:00.0000000' AS DateTime2), N'b78f7a58-f0ef-4e53-9d89-96b928fc0dca', N'Level 1', N'Active', CAST(N'2025-11-28T09:10:34.1566741' AS DateTime2), NULL)
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'abab7932-9628-4e11-afbc-08de2e5de8a7', N'94a5ce45-c184-4f87-946a-26ee5748f564')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'42fbe37e-3abf-4426-afc5-08de2e5de8a7', N'94a5ce45-c184-4f87-946a-26ee5748f564')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'd3f515ba-edfc-4f10-afb8-08de2e5de8a7', N'4db36147-0d00-4b9f-b01e-38c4961d75ae')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'51e67371-86c6-4347-afc4-08de2e5de8a7', N'4db36147-0d00-4b9f-b01e-38c4961d75ae')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'b0e95f85-ebe8-42c0-8b67-813e292b571f', N'4db36147-0d00-4b9f-b01e-38c4961d75ae')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'd3f515ba-edfc-4f10-afb8-08de2e5de8a7', N'f8b49fc6-a76e-41ca-a6b4-3f7ec1dcb066')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'ed961d30-bca1-4141-afc2-08de2e5de8a7', N'f8b49fc6-a76e-41ca-a6b4-3f7ec1dcb066')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'c374d224-0e43-4026-afbb-08de2e5de8a7', N'00ed7ef1-1d0e-4b6a-ba2a-40b8f298f85e')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'4a998dd6-c766-4244-afb7-08de2e5de8a7', N'3287c77f-ff24-41d1-a690-53d92b9f9886')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'c374d224-0e43-4026-afbb-08de2e5de8a7', N'0bef3ada-1789-4645-91d7-6edb181c0ea8')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'abe16bd7-cf52-4e3c-afc1-08de2e5de8a7', N'7a517fc2-fa10-4f81-b40a-7f06a2d60e8f')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'3a9dd813-55e2-406c-afc0-08de2e5de8a7', N'53474655-3e11-402c-b8b4-87a16e9690f5')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'4a998dd6-c766-4244-afb7-08de2e5de8a7', N'b78f7a58-f0ef-4e53-9d89-96b928fc0dca')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'b0e95f85-ebe8-42c0-8b67-813e292b571f', N'b78f7a58-f0ef-4e53-9d89-96b928fc0dca')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'384c9d3f-da23-4107-afbe-08de2e5de8a7', N'c9e40b76-7b24-49ff-aa81-97f30c7a77bd')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'dcf948a5-9dbe-4611-afb9-08de2e5de8a7', N'fe7e599e-93aa-4389-81ea-9b5757ff79ac')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'c25bd4c4-f334-47fd-afbd-08de2e5de8a7', N'a8d7cd5c-43e7-456d-ac85-b60a2eb090b2')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'da6a8fac-f2bf-4a0a-afbf-08de2e5de8a7', N'ad2587c4-83dc-47ba-a78d-c9f5cd7b558a')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'392526be-cae1-4ea5-afba-08de2e5de8a7', N'c6f967eb-12a6-4e39-88c5-dbdc76d0c2ab')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'2a421a1b-938a-410b-afc3-08de2e5de8a7', N'c6f967eb-12a6-4e39-88c5-dbdc76d0c2ab')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'dcf948a5-9dbe-4611-afb9-08de2e5de8a7', N'7b0047d6-01ee-472d-88ec-f99b507d8f24')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'b0e95f85-ebe8-42c0-8b67-813e292b571f', N'7b0047d6-01ee-472d-88ec-f99b507d8f24')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'2aca228c-666c-424f-c356-08de2e5de745')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'4a998dd6-c766-4244-afb7-08de2e5de8a7', N'2af6540c-5cb5-4b10-c357-08de2e5de745')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'd3f515ba-edfc-4f10-afb8-08de2e5de8a7', N'2af6540c-5cb5-4b10-c357-08de2e5de745')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'dcf948a5-9dbe-4611-afb9-08de2e5de8a7', N'2af6540c-5cb5-4b10-c357-08de2e5de745')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'392526be-cae1-4ea5-afba-08de2e5de8a7', N'2af6540c-5cb5-4b10-c357-08de2e5de745')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'c374d224-0e43-4026-afbb-08de2e5de8a7', N'2af6540c-5cb5-4b10-c357-08de2e5de745')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'abab7932-9628-4e11-afbc-08de2e5de8a7', N'2af6540c-5cb5-4b10-c357-08de2e5de745')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'c25bd4c4-f334-47fd-afbd-08de2e5de8a7', N'2af6540c-5cb5-4b10-c357-08de2e5de745')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'384c9d3f-da23-4107-afbe-08de2e5de8a7', N'2af6540c-5cb5-4b10-c357-08de2e5de745')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'da6a8fac-f2bf-4a0a-afbf-08de2e5de8a7', N'2af6540c-5cb5-4b10-c357-08de2e5de745')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'3a9dd813-55e2-406c-afc0-08de2e5de8a7', N'2af6540c-5cb5-4b10-c357-08de2e5de745')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'abe16bd7-cf52-4e3c-afc1-08de2e5de8a7', N'2af6540c-5cb5-4b10-c357-08de2e5de745')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'ed961d30-bca1-4141-afc2-08de2e5de8a7', N'2af6540c-5cb5-4b10-c357-08de2e5de745')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'2a421a1b-938a-410b-afc3-08de2e5de8a7', N'2af6540c-5cb5-4b10-c357-08de2e5de745')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'51e67371-86c6-4347-afc4-08de2e5de8a7', N'2af6540c-5cb5-4b10-c357-08de2e5de745')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'42fbe37e-3abf-4426-afc5-08de2e5de8a7', N'2af6540c-5cb5-4b10-c357-08de2e5de745')
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'1f1402b0-d1bb-4b03-afb6-08de2e5de8a7', N'System', N'Coordinator', N'Coordinator', 1, CAST(N'2025-11-28T09:09:59.5302959' AS DateTime2), NULL, N'coordinator', N'COORDINATOR', N'coordinator@dilmunreading.com', N'COORDINATOR@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEOETcWQpass3Pdy4dass7lkXmI0LFv5aq65+2XRqRNmVu0IQLwwazswLW2maD/4w0w==', N'3LXR76YYJNZ76TQMQPAVFQNPBJXFUTTQ', N'60466f63-7158-4b42-9c8b-2cc4f5105312', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'4a998dd6-c766-4244-afb7-08de2e5de8a7', N'Ali', N'Mansoor', N'Teacher', 1, CAST(N'2025-11-28T09:10:03.0896396' AS DateTime2), NULL, N'teacher.ali', N'TEACHER.ALI', N'ali.mansoor@dilmunreading.com', N'ALI.MANSOOR@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEAWtI4qnzwJ0Iq00U4MDPVXhB6KYqmtEsbCIjf2YyO95zLCGrQPLxNtoLgjbAJ0tqQ==', N'PDFZZL3EX3DVPR4P7ODG5DGHHXMPHMGT', N'a6f4c668-232c-4fbe-bf9f-f828f81a8451', N'+97333000001', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'd3f515ba-edfc-4f10-afb8-08de2e5de8a7', N'Farah', N'Al-Qattan', N'Teacher', 1, CAST(N'2025-11-28T09:10:04.8042603' AS DateTime2), NULL, N'teacher.farah', N'TEACHER.FARAH', N'farah.qattan@dilmunreading.com', N'FARAH.QATTAN@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEGOoJajmfq36nD6gEB/ZD1dchvC/RBchm1Nhw2GbQsoT7n3Fn9kLhX62W86pQ2qSWA==', N'N7MRY5CKPPIXCTMK4JOY6U2YVWDRMXMR', N'33b670b1-a57a-42bc-be44-cc79a54c8fe3', N'+97333000002', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'dcf948a5-9dbe-4611-afb9-08de2e5de8a7', N'Saad', N'Al-Noaimi', N'Teacher', 1, CAST(N'2025-11-28T09:10:06.5539674' AS DateTime2), NULL, N'teacher.saad', N'TEACHER.SAAD', N'saad.noaimi@dilmunreading.com', N'SAAD.NOAIMI@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEFh/x0mpyYwjwoC2TRcCg0qFQRDxpQmyPeRRC2t1rnL1r1hwz/igDTt4fCH6l8gdAw==', N'NDFTZJECLAGXGZPMB3VOUJ7WDHCZ2DJH', N'6ce9fd8b-f6a5-41cf-b10e-2d38224a0988', N'+97333000003', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'392526be-cae1-4ea5-afba-08de2e5de8a7', N'Huda', N'Al-Khaldi', N'Teacher', 1, CAST(N'2025-11-28T09:10:08.3377837' AS DateTime2), NULL, N'teacher.huda', N'TEACHER.HUDA', N'huda.khaldi@dilmunreading.com', N'HUDA.KHALDI@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEIkUKuW4v3YDSSxgqfNdb+MQBleyyId8On2E0XTeG5mkp9aN+HHVaAOuPeuPDiP+cQ==', N'WQ3EJWJ55GVAIGO5XGRENSOFBZ2C4EFY', N'22482d0b-0232-41ba-95c5-8103f7965276', N'+97333000004', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'c374d224-0e43-4026-afbb-08de2e5de8a7', N'Malek', N'Al-Sabah', N'Teacher', 1, CAST(N'2025-11-28T09:10:10.0874622' AS DateTime2), NULL, N'teacher.malek', N'TEACHER.MALEK', N'malek.sabah@dilmunreading.com', N'MALEK.SABAH@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAECn5VkONA8M+2rLxNRNaKbbi52O8cxPoNYYsuWN7q53/0FxIjcv84lK7bdmNrb7KDg==', N'BMZGE2LOK4U5NZAWOGGVJRDTG7GW3JEB', N'c93bf9cc-f776-481a-ac63-859a77dbc82a', N'+97333000005', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'abab7932-9628-4e11-afbc-08de2e5de8a7', N'Reem', N'Al-Ansari', N'Teacher', 1, CAST(N'2025-11-28T09:10:11.8372108' AS DateTime2), NULL, N'teacher.reem', N'TEACHER.REEM', N'reem.ansari@dilmunreading.com', N'REEM.ANSARI@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEAvQP3ep8pHjr6R8QkptPEenOEPfpSlc6T8oVaQQ9YIMUQvh0PEJy5z36Hh6KB93Lg==', N'RYTZUXIWFXY42QEN4X64TB3CTALGUVAB', N'29fa79cf-7485-43a6-afc1-650f82ae72ba', N'+97333000006', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'c25bd4c4-f334-47fd-afbd-08de2e5de8a7', N'Samer', N'Al-Sharif', N'Teacher', 1, CAST(N'2025-11-28T09:10:13.5928210' AS DateTime2), NULL, N'teacher.samer', N'TEACHER.SAMER', N'samer.sharif@dilmunreading.com', N'SAMER.SHARIF@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEMWMj2QVZQOAMzki7I5KgtcEUnFBCJTfNb+F07tj1t89nbBzqI6Ef06oVc84fz2k7Q==', N'IYZOTH3Z4ZVIUA2C5HI5ILM2MMNQGCW6', N'437944fe-89ea-4c91-9380-2461b08ed98e', N'+97333000007', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'384c9d3f-da23-4107-afbe-08de2e5de8a7', N'Lama', N'Al-Harthy', N'Teacher', 1, CAST(N'2025-11-28T09:10:15.4636437' AS DateTime2), NULL, N'teacher.lama', N'TEACHER.LAMA', N'lama.harthy@dilmunreading.com', N'LAMA.HARTHY@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEIXAQ+O0fN6KswjMX1bkCiuXis0nx32mozQtuD0lE+eBY7Hq5aOEvq6IyMlAqV0fug==', N'PDMGGJMSZA6O6ILHSBBYKM75RQXUOP6X', N'0e69d9fc-5597-4f23-b6c1-355b5be734fb', N'+97333000008', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'da6a8fac-f2bf-4a0a-afbf-08de2e5de8a7', N'Yousef', N'Al-Rifai', N'Teacher', 1, CAST(N'2025-11-28T09:10:17.9120005' AS DateTime2), NULL, N'teacher.yousef', N'TEACHER.YOUSEF', N'yousef.rifai@dilmunreading.com', N'YOUSEF.RIFAI@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAECYlHfBb9umG4ZZCiUOV+TiRqmXDtQQAFvrM3G8bAHhD+FkDEJSbJMDaAw+cZeK9nA==', N'XRZPYAR463EMNJ473HVMHC6FL6BHSVAG', N'c2bcc7a0-3dd4-4589-9eed-a9898fc87cd3', N'+97333000009', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'3a9dd813-55e2-406c-afc0-08de2e5de8a7', N'Basma', N'Al-Hassan', N'Teacher', 1, CAST(N'2025-11-28T09:10:19.6694205' AS DateTime2), NULL, N'teacher.basma', N'TEACHER.BASMA', N'basma.hassan@dilmunreading.com', N'BASMA.HASSAN@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEMlbGic23YMyQWLDLYfGsdCj/zQEsEqfrMM9KFEI15v1tvZfpPuLtH/ihbUu9Q1zBw==', N'PCLVV3JAGFHYMX5UCTNORGWSL2YQJWJE', N'31fec384-00c6-4d7f-a864-17072357edd5', N'+97333000010', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'abe16bd7-cf52-4e3c-afc1-08de2e5de8a7', N'Karim', N'Al-Saleh', N'Teacher', 1, CAST(N'2025-11-28T09:10:21.5938204' AS DateTime2), NULL, N'teacher.karim', N'TEACHER.KARIM', N'karim.saleh@dilmunreading.com', N'KARIM.SALEH@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAELfSZiLJh9/lOA8M0K3um4FxGqLg3GT062W9Ih8vnEahYD6fqkuYoxH2EXEUvik2Ww==', N'3OQ74ZOI5VPIXRR7E67IUAHTLIS5DITL', N'0976508f-180d-477e-8f59-0ffddb4ffa5e', N'+97333000011', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'ed961d30-bca1-4141-afc2-08de2e5de8a7', N'Mona', N'Al-Tamimi', N'Teacher', 1, CAST(N'2025-11-28T09:10:23.3437077' AS DateTime2), NULL, N'teacher.mona', N'TEACHER.MONA', N'mona.tamimi@dilmunreading.com', N'MONA.TAMIMI@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEGk+7Ynf4QKLKl2NvsVI2LDA84uAoGOO4i/NIdJz24O7DzhYxgp+dxHi0V0dBg7QxQ==', N'LQGVEWIBR74DJH6LOIN43MDFYMMBBUN2', N'07ace3a5-a7a8-4926-a7be-a8206819b52a', N'+97333000012', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'2a421a1b-938a-410b-afc3-08de2e5de8a7', N'Sultan', N'Al-Zayani', N'Teacher', 1, CAST(N'2025-11-28T09:10:26.6468478' AS DateTime2), NULL, N'teacher.sultan', N'TEACHER.SULTAN', N'sultan.zayani@dilmunreading.com', N'SULTAN.ZAYANI@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEKeHmKdSErNtsChmld8rscBC5dcio0gSmlrJau1jys+TASryqdrryPnEQYXl/SXWyw==', N'4TVEKSW4J6TZD2EWPZ44ER7L6QCAB6I4', N'792fea97-43f4-40e2-9783-b941eabec751', N'+97333000013', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'51e67371-86c6-4347-afc4-08de2e5de8a7', N'Nour', N'Al-Darwish', N'Teacher', 1, CAST(N'2025-11-28T09:10:28.8814599' AS DateTime2), NULL, N'teacher.nour', N'TEACHER.NOUR', N'nour.darwish@dilmunreading.com', N'NOUR.DARWISH@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEGgA2OJKwThkYL1VTYfX/PTNOpW5E7FX+k57LrnzG9massl6UvPNrSuRQN/GBR/Gow==', N'TE3VMW2GDZDTCIT65TEOIKK4U5I7P5PG', N'4f8292d1-7347-4b73-b260-f38a8ac9059f', N'+97333000014', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'42fbe37e-3abf-4426-afc5-08de2e5de8a7', N'Ayman', N'Al-Hadid', N'Teacher', 1, CAST(N'2025-11-28T09:10:30.7869136' AS DateTime2), NULL, N'teacher.ayman', N'TEACHER.AYMAN', N'ayman.hadid@dilmunreading.com', N'AYMAN.HADID@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEIHJF4rHnq7ib67NpMRNZ249QGor4XAeE4KHwR0V7mjbQyNMbaroSyk4VcOrH0k1pw==', N'XOL2UFXIWRAZZEGFZ4TGEXQ5TMDQYZHK', N'e8a11389-8fcd-4987-a08f-57c38cf32cb2', N'+97333000015', 1, 0, NULL, 1, 0)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Books_Title_Author]    Script Date: 11/30/2025 4:51:05 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Books_Title_Author] ON [dbo].[Books]
(
	[Title] ASC,
	[Author] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Classrooms_Name]    Script Date: 11/30/2025 4:51:05 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Classrooms_Name] ON [dbo].[Classrooms]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ReadingProgress_BookId]    Script Date: 11/30/2025 4:51:05 PM ******/
CREATE NONCLUSTERED INDEX [IX_ReadingProgress_BookId] ON [dbo].[ReadingProgress]
(
	[BookId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ReadingProgress_StudentId_WeekStartDate]    Script Date: 11/30/2025 4:51:05 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ReadingProgress_StudentId_WeekStartDate] ON [dbo].[ReadingProgress]
(
	[StudentId] ASC,
	[WeekStartDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_ReportCaches_ReportType_ScopeId_PeriodStart_PeriodEnd]    Script Date: 11/30/2025 4:51:05 PM ******/
CREATE NONCLUSTERED INDEX [IX_ReportCaches_ReportType_ScopeId_PeriodStart_PeriodEnd] ON [dbo].[ReportCaches]
(
	[ReportType] ASC,
	[ScopeId] ASC,
	[PeriodStart] ASC,
	[PeriodEnd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_RoleClaims_RoleId]    Script Date: 11/30/2025 4:51:05 PM ******/
CREATE NONCLUSTERED INDEX [IX_RoleClaims_RoleId] ON [dbo].[RoleClaims]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 11/30/2025 4:51:05 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[Roles]
(
	[NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Students_ClassroomId_Status]    Script Date: 11/30/2025 4:51:05 PM ******/
CREATE NONCLUSTERED INDEX [IX_Students_ClassroomId_Status] ON [dbo].[Students]
(
	[ClassroomId] ASC,
	[Status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Students_StudentCode]    Script Date: 11/30/2025 4:51:05 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Students_StudentCode] ON [dbo].[Students]
(
	[StudentCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_TeacherClasses_ClassroomId]    Script Date: 11/30/2025 4:51:05 PM ******/
CREATE NONCLUSTERED INDEX [IX_TeacherClasses_ClassroomId] ON [dbo].[TeacherClasses]
(
	[ClassroomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserClaims_UserId]    Script Date: 11/30/2025 4:51:05 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserClaims_UserId] ON [dbo].[UserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserLogins_UserId]    Script Date: 11/30/2025 4:51:05 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserLogins_UserId] ON [dbo].[UserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserRoles_RoleId]    Script Date: 11/30/2025 4:51:05 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserRoles_RoleId] ON [dbo].[UserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [EmailIndex]    Script Date: 11/30/2025 4:51:05 PM ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[Users]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Users_UserName]    Script Date: 11/30/2025 4:51:05 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Users_UserName] ON [dbo].[Users]
(
	[UserName] ASC
)
WHERE ([UserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 11/30/2025 4:51:05 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[Users]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ReadingProgress] ADD  DEFAULT ((0)) FOR [DurationMinutes]
GO
ALTER TABLE [dbo].[ReadingProgress]  WITH CHECK ADD  CONSTRAINT [FK_ReadingProgress_Books_BookId] FOREIGN KEY([BookId])
REFERENCES [dbo].[Books] ([Id])
GO
ALTER TABLE [dbo].[ReadingProgress] CHECK CONSTRAINT [FK_ReadingProgress_Books_BookId]
GO
ALTER TABLE [dbo].[ReadingProgress]  WITH CHECK ADD  CONSTRAINT [FK_ReadingProgress_Students_StudentId] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Students] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ReadingProgress] CHECK CONSTRAINT [FK_ReadingProgress_Students_StudentId]
GO
ALTER TABLE [dbo].[RoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_RoleClaims_Roles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RoleClaims] CHECK CONSTRAINT [FK_RoleClaims_Roles_RoleId]
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [FK_Students_Classrooms_ClassroomId] FOREIGN KEY([ClassroomId])
REFERENCES [dbo].[Classrooms] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [FK_Students_Classrooms_ClassroomId]
GO
ALTER TABLE [dbo].[TeacherClasses]  WITH CHECK ADD  CONSTRAINT [FK_TeacherClasses_Classrooms_ClassroomId] FOREIGN KEY([ClassroomId])
REFERENCES [dbo].[Classrooms] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TeacherClasses] CHECK CONSTRAINT [FK_TeacherClasses_Classrooms_ClassroomId]
GO
ALTER TABLE [dbo].[UserClaims]  WITH CHECK ADD  CONSTRAINT [FK_UserClaims_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserClaims] CHECK CONSTRAINT [FK_UserClaims_Users_UserId]
GO
ALTER TABLE [dbo].[UserLogins]  WITH CHECK ADD  CONSTRAINT [FK_UserLogins_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserLogins] CHECK CONSTRAINT [FK_UserLogins_Users_UserId]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Roles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Roles_RoleId]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Users_UserId]
GO
ALTER TABLE [dbo].[UserTokens]  WITH CHECK ADD  CONSTRAINT [FK_UserTokens_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserTokens] CHECK CONSTRAINT [FK_UserTokens_Users_UserId]
GO
ALTER DATABASE [db33679] SET  READ_WRITE 
GO
