/****** Object:  Database [DilmunReadingDb] ******/
CREATE DATABASE [DilmunReadingDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DilmunReadingDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\DilmunReadingDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DilmunReadingDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\DilmunReadingDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [DilmunReadingDb] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DilmunReadingDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DilmunReadingDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DilmunReadingDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DilmunReadingDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DilmunReadingDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DilmunReadingDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [DilmunReadingDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DilmunReadingDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DilmunReadingDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DilmunReadingDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DilmunReadingDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DilmunReadingDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DilmunReadingDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DilmunReadingDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DilmunReadingDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DilmunReadingDb] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DilmunReadingDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DilmunReadingDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DilmunReadingDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DilmunReadingDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DilmunReadingDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DilmunReadingDb] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [DilmunReadingDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DilmunReadingDb] SET RECOVERY FULL 
GO
ALTER DATABASE [DilmunReadingDb] SET  MULTI_USER 
GO
ALTER DATABASE [DilmunReadingDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DilmunReadingDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DilmunReadingDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DilmunReadingDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DilmunReadingDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DilmunReadingDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'DilmunReadingDb', N'ON'
GO
ALTER DATABASE [DilmunReadingDb] SET QUERY_STORE = ON
GO
ALTER DATABASE [DilmunReadingDb] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 11/28/2025 2:26:49 PM ******/
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
/****** Object:  Table [dbo].[AuditLogs]    Script Date: 11/28/2025 2:26:49 PM ******/
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
/****** Object:  Table [dbo].[BackupRecords]    Script Date: 11/28/2025 2:26:49 PM ******/
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
/****** Object:  Table [dbo].[Books]    Script Date: 11/28/2025 2:26:50 PM ******/
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
/****** Object:  Table [dbo].[Classrooms]    Script Date: 11/28/2025 2:26:50 PM ******/
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
/****** Object:  Table [dbo].[PasswordResetRequests]    Script Date: 11/28/2025 2:26:50 PM ******/
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
/****** Object:  Table [dbo].[ReadingProgress]    Script Date: 11/28/2025 2:26:50 PM ******/
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
/****** Object:  Table [dbo].[ReportCaches]    Script Date: 11/28/2025 2:26:50 PM ******/
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
/****** Object:  Table [dbo].[RoleClaims]    Script Date: 11/28/2025 2:26:50 PM ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 11/28/2025 2:26:50 PM ******/
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
/****** Object:  Table [dbo].[Students]    Script Date: 11/28/2025 2:26:50 PM ******/
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
/****** Object:  Table [dbo].[SystemSettings]    Script Date: 11/28/2025 2:26:50 PM ******/
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
/****** Object:  Table [dbo].[TeacherClasses]    Script Date: 11/28/2025 2:26:50 PM ******/
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
/****** Object:  Table [dbo].[UserClaims]    Script Date: 11/28/2025 2:26:50 PM ******/
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
/****** Object:  Table [dbo].[UserLogins]    Script Date: 11/28/2025 2:26:50 PM ******/
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
/****** Object:  Table [dbo].[UserRoles]    Script Date: 11/28/2025 2:26:50 PM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 11/28/2025 2:26:50 PM ******/
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
/****** Object:  Table [dbo].[UserTokens]    Script Date: 11/28/2025 2:26:50 PM ******/
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
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (1, N'dd949d78-eec8-4bae-af44-08de2daa1c9d', N'Login', N'System', NULL, N'Coordinator login', N'192.168.1.20', CAST(N'2025-11-15T11:43:05.1141140' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (2, N'dd949d78-eec8-4bae-af44-08de2daa1c9d', N'Create', N'Classroom', N'ed2a4a84-0748-4df8-8e1a-09f3d15db3a2', N'Created Fasl 1C', N'192.168.1.20', CAST(N'2025-11-16T11:43:05.1142500' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (3, N'df69c88c-ee7c-475d-af45-08de2daa1c9d', N'Login', N'System', NULL, N'Teacher Ali login', N'192.168.1.20', CAST(N'2025-11-17T11:43:05.1142528' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (4, N'df69c88c-ee7c-475d-af45-08de2daa1c9d', N'Create', N'Student', N'5d2a8033-372a-4467-984b-9d3eae6a8a44', N'Logged reading session for Ahmad', N'192.168.1.20', CAST(N'2025-11-17T11:43:05.1142547' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (5, N'164a7ab3-9f76-47fd-af46-08de2daa1c9d', N'Update', N'Student', N'2dd6c316-53fa-41cd-9db7-ce884156eda6', N'Updated Sara profile', N'192.168.1.20', CAST(N'2025-11-18T11:43:05.1142555' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (6, N'b8343aa7-26e1-4e21-af47-08de2daa1c9d', N'Create', N'Student', N'8c08b63c-1309-4c2e-aaf2-7ad983640d08', N'Recorded Noura practice', N'192.168.1.20', CAST(N'2025-11-18T11:43:05.1142572' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (7, N'12be97a2-6d1d-444b-af48-08de2daa1c9d', N'Create', N'Student', N'99d684d9-72cb-414a-9cdf-65bbe4d3ccdd', N'Documented Hamad progress', N'192.168.1.20', CAST(N'2025-11-19T11:43:05.1142581' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (8, N'99895339-15de-48bd-af49-08de2daa1c9d', N'Create', N'Student', N'3cef9d40-a8d4-47ed-9e7a-7f4ab3022e44', N'Submitted Omar weekly report', N'192.168.1.20', CAST(N'2025-11-20T11:43:05.1142588' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (9, N'253f63ce-5a1e-4015-af4a-08de2daa1c9d', N'Update', N'Classroom', N'907edcd6-74f5-48d7-8a47-d184103861aa', N'Adjusted Fasl 4B plan', N'192.168.1.20', CAST(N'2025-11-20T11:43:05.1142596' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (10, N'189fc27f-7311-4ba9-af4b-08de2daa1c9d', N'Create', N'Student', N'fbe5df14-7867-4d12-84ed-296e6648333a', N'Added Sami progress', N'192.168.1.20', CAST(N'2025-11-21T11:43:05.1142608' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (11, N'aba0ae4a-bac8-4410-af4c-08de2daa1c9d', N'Create', N'Student', N'c5b8cbcc-6f3c-4f30-82e5-c07c99f88910', N'Captured Dana reading', N'192.168.1.20', CAST(N'2025-11-21T11:43:05.1142614' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (12, N'9c66667a-e0f1-4031-af4d-08de2daa1c9d', N'Create', N'Student', N'50609994-6eac-4d02-86dd-d54a62e7c454', N'Recorded Rakan session', N'192.168.1.20', CAST(N'2025-11-22T11:43:05.1142619' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (13, N'1c631b53-a53b-48fb-af4e-08de2daa1c9d', N'Create', N'Book', N'690ccd85-2c9d-47aa-a093-c98b0bb2d05e', N'Suggested new resource', N'192.168.1.20', CAST(N'2025-11-23T11:43:05.1142634' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (14, N'b3926af2-2f1c-4a7f-af4f-08de2daa1c9d', N'Delete', N'Student', N'09cc3d59-73b4-4268-a34d-e3a081cd1c57', N'Removed duplicate entry', N'192.168.1.20', CAST(N'2025-11-24T11:43:05.1142641' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (15, N'54eb46b8-a0c8-4c6f-af52-08de2daa1c9d', N'Login', N'System', NULL, N'Teacher Nour login', N'192.168.1.20', CAST(N'2025-11-25T11:43:05.1142646' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (16, N'dd949d78-eec8-4bae-af44-08de2daa1c9d', N'Login', NULL, NULL, N'User coordinator logged in', N'::1', CAST(N'2025-11-27T11:43:18.6286417' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (17, N'dd949d78-eec8-4bae-af44-08de2daa1c9d', N'Create', NULL, NULL, N'Create action on ', N'::1', CAST(N'2025-11-27T11:44:30.2244914' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (18, N'dd949d78-eec8-4bae-af44-08de2daa1c9d', N'Login', NULL, NULL, N'User coordinator logged in', N'::1', CAST(N'2025-11-27T11:46:14.7512636' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (19, N'dd949d78-eec8-4bae-af44-08de2daa1c9d', N'Login', NULL, NULL, N'User coordinator logged in', N'::1', CAST(N'2025-11-27T12:31:19.9206496' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (20, N'dd949d78-eec8-4bae-af44-08de2daa1c9d', N'Create', NULL, NULL, N'Create action on ', N'::1', CAST(N'2025-11-27T12:33:35.7905067' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (21, N'dd949d78-eec8-4bae-af44-08de2daa1c9d', N'Update', N'Student', N'58d62c5f-138d-4268-be2b-17c81b3e6622', N'Update Student', N'::1', CAST(N'2025-11-27T12:33:36.1989426' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (22, N'dd949d78-eec8-4bae-af44-08de2daa1c9d', N'Create', NULL, NULL, N'Create action on ', N'::1', CAST(N'2025-11-27T12:34:04.4247726' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (23, N'dd949d78-eec8-4bae-af44-08de2daa1c9d', N'Delete', N'Student', N'8c08b63c-1309-4c2e-aaf2-7ad983640d08', N'Delete Student', N'::1', CAST(N'2025-11-27T12:34:04.7191536' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (24, N'dd949d78-eec8-4bae-af44-08de2daa1c9d', N'Create', NULL, NULL, N'Create action on ', N'::1', CAST(N'2025-11-27T12:34:17.0980709' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (25, N'dd949d78-eec8-4bae-af44-08de2daa1c9d', N'Update', N'Student', N'8c08b63c-1309-4c2e-aaf2-7ad983640d08', N'Update Student', N'::1', CAST(N'2025-11-27T12:34:17.1342721' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (26, N'dd949d78-eec8-4bae-af44-08de2daa1c9d', N'Create', NULL, NULL, N'Create action on ', N'::1', CAST(N'2025-11-27T12:34:48.0942337' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (27, N'dd949d78-eec8-4bae-af44-08de2daa1c9d', N'Create', NULL, NULL, N'Create action on ', N'::1', CAST(N'2025-11-27T12:45:24.6064182' AS DateTime2))
GO
INSERT [dbo].[AuditLogs] ([Id], [UserId], [ActionType], [Entity], [EntityId], [Description], [IpAddress], [CreatedAtUtc]) VALUES (28, N'dd949d78-eec8-4bae-af44-08de2daa1c9d', N'Login', NULL, NULL, N'User coordinator logged in', N'::1', CAST(N'2025-11-27T12:45:26.1081574' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[AuditLogs] OFF
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'3908033b-8577-469e-8231-03b4d31ad9c0', N'Hikayat Al-Bahr', N'Salem Al-Haddad', N'Qissa Qasira', N'Level 2', N'Available', CAST(N'2025-11-27T11:43:04.3588064' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'60677ccc-ed9e-426f-a34e-04751620a737', N'Turuq Al-Nujoom', N'Salwa Al-Khaldi', N'Ilmi', N'Level 3', N'Available', CAST(N'2025-11-27T11:43:04.3609269' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'c28f2745-a990-410a-a9a5-05728724ace0', N'Mawj Al-Hurriyah', N'Tariq Al-Zayani', N'Shaeri', N'Level 6', N'Available', CAST(N'2025-11-27T11:43:04.3609264' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'ef5a7516-7322-4156-b9c8-173c86b87574', N'Juzur Al-Marjan', N'Fahad Al-Dosari', N'Khayaal', N'Level 5', N'Available', CAST(N'2025-11-27T11:43:04.3609255' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'77275b62-7fae-4b0d-9a1f-2603b2526860', N'Kawkab Al-Hikma', N'Huda Al-Sabah', N'Tarbawi', N'Level 4', N'Available', CAST(N'2025-11-27T11:43:04.3609251' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'568805b5-81e6-4aea-94f6-2733fff6552e', N'Qasr Al-Buhur', N'Jamal Al-Sabah', N'Mughamara', N'Level 4', N'Available', CAST(N'2025-11-27T11:43:04.3609273' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'b1be2588-a44a-453f-bf90-3f39a0895d04', N'Kitab Al-Sahra', N'Imran Al-Badi', N'Mughamara', N'Level 2', N'Available', CAST(N'2025-11-27T11:43:04.3609298' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'dcfdcf99-0b38-4bc6-a4af-49b9a3ca9380', N'Sunduq Al-Asrar', N'Laila Al-Hooti', N'Silsila', N'Level 2', N'Available', CAST(N'2025-11-27T11:43:04.3609260' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'fc936710-64f2-4f4a-8e9c-4f006ee982eb', N'Sirr Wahat Lulu', N'Maryam Al-Najjar', N'Mughamara', N'Level 3', N'Available', CAST(N'2025-11-27T11:43:04.3609227' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'df3375a7-29b8-44f9-8102-51935e0b0634', N'Siraj Al-Hikayat', N'Yara Al-Mansoori', N'Qissa Qasira', N'Level 3', N'Available', CAST(N'2025-11-27T11:43:04.3609302' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'1b855a93-fe53-4bf4-9d7f-63bd60c8f9cf', N'Nabd Al-Kalimah', N'Sami Al-Rashed', N'Adabi', N'Level 4', N'Available', CAST(N'2025-11-27T11:43:04.3609307' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'38e720da-09e6-409b-8815-7ac839290fd0', N'Qitar Al-Amani', N'Nasser Al-Mutawa', N'Ilham', N'Level 1', N'Available', CAST(N'2025-11-27T11:43:04.3609246' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'f5395b84-c0c3-4856-b456-80c1e0aea431', N'Rihlat Nour', N'Dalia Al-Mutairi', N'Tarbawi', N'Level 1', N'Available', CAST(N'2025-11-27T11:43:04.3609284' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'690ccd85-2c9d-47aa-a093-c98b0bb2d05e', N'Fann Al-Qiraah', N'Rania Al-Sayegh', N'Dalil', N'Level 5', N'Available', CAST(N'2025-11-27T11:43:04.3609289' AS DateTime2), NULL)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [Category], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'ea4b742e-7564-4224-b330-cff1f9b8a0e2', N'Awtar Al-Qamar', N'Hasan Al-Kuwari', N'Khayaal', N'Level 6', N'Available', CAST(N'2025-11-27T11:43:04.3609294' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'aeabbcc9-cde9-4f3d-a023-0738490371b9', N'Class 5A', N'Grade 5', N'Active', CAST(N'2025-11-27T11:43:04.1830228' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'ed2a4a84-0748-4df8-8e1a-09f3d15db3a2', N'Class 1C', N'Grade 1', N'Active', CAST(N'2025-11-27T11:43:04.1830148' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'2b82b498-fc77-4f90-a0d5-16038dc75a9e', N'Class 4C', N'Grade 4', N'Active', CAST(N'2025-11-27T11:43:04.1830217' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'90e9f7ce-c0fd-41ea-9c73-188bf399ced3', N'Class 2A', N'Grade 2', N'Active', CAST(N'2025-11-27T11:43:04.1830154' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'54ed37b4-2474-47eb-8942-370b78c7621a', N'Class 5C', N'Grade 5', N'Active', CAST(N'2025-11-27T11:43:04.1830238' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'a944131b-db4d-4914-b96a-512be08b9305', N'Class 4A', N'Grade 4', N'Active', CAST(N'2025-11-27T11:43:04.1830208' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'52961bae-01a1-4e8b-9279-5af7740bc4eb', N'Class 3C', N'Grade 3', N'Active', CAST(N'2025-11-27T11:43:04.1830204' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'bd3560b9-4e20-4955-a64f-5ea7927efe51', N'Class 1B', N'Grade 1', N'Active', CAST(N'2025-11-27T11:43:04.1830136' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'04b86bd2-9a0f-442a-bf32-69f4f801a1ab', N'Class 2C', N'Grade 2', N'Active', CAST(N'2025-11-27T11:43:04.1830190' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'a63afedc-2f49-4d86-af84-98f6b0dfdf81', N'Class 2B', N'Grade 2', N'Active', CAST(N'2025-11-27T11:43:04.1830185' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'19dcdaf0-63a8-428c-8f02-b84553abf244', N'Class 1A', N'Grade 1', N'Active', CAST(N'2025-11-27T11:43:04.1825700' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'907edcd6-74f5-48d7-8a47-d184103861aa', N'Class 4B', N'Grade 4', N'Active', CAST(N'2025-11-27T11:43:04.1830213' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'61224290-de1d-416a-8d42-dbb10c535578', N'Class 3A', N'Grade 3', N'Active', CAST(N'2025-11-27T11:43:04.1830195' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'e0a62056-2abe-42fe-9ec1-eb8a473e027f', N'Class 3B', N'Grade 3', N'Active', CAST(N'2025-11-27T11:43:04.1830199' AS DateTime2), NULL)
GO
INSERT [dbo].[Classrooms] ([Id], [Name], [YearGroup], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'a4287f3c-9ec1-45c0-970a-f271be6d1fc4', N'Class 5B', N'Grade 5', N'Active', CAST(N'2025-11-27T11:43:04.1830233' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'c7ad45d6-5cfb-4bbd-8520-1c892a644a9a', N'5e2de917-3848-4417-bdaf-e14addac0c4c', N'12be97a2-6d1d-444b-af48-08de2daa1c9d', N'60677ccc-ed9e-426f-a34e-04751620a737', CAST(N'2024-09-23' AS Date), N'Level 4', 45, N'Solid vocabulary', CAST(N'2025-11-27T11:43:04.9528462' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'e0298005-5cef-432c-bc53-27e577883758', N'58d62c5f-138d-4268-be2b-17c81b3e6622', N'99895339-15de-48bd-af49-08de2daa1c9d', N'f5395b84-c0c3-4856-b456-80c1e0aea431', CAST(N'2024-09-30' AS Date), N'Level 5', 50, N'Great summarizing', CAST(N'2025-11-27T11:43:04.9528493' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'00973405-9118-4f38-b1fe-3f248ef723c6', N'c5b8cbcc-6f3c-4f30-82e5-c07c99f88910', N'aba0ae4a-bac8-4410-af4c-08de2daa1c9d', N'df3375a7-29b8-44f9-8102-51935e0b0634', CAST(N'2024-10-14' AS Date), N'Level 6', 60, N'Smooth storyteller', CAST(N'2025-11-27T11:43:04.9528546' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'74b7ff00-fcc2-487e-ba82-4767d249e4ca', N'2dd6c316-53fa-41cd-9db7-ce884156eda6', N'164a7ab3-9f76-47fd-af46-08de2daa1c9d', N'77275b62-7fae-4b0d-9a1f-2603b2526860', CAST(N'2024-09-09' AS Date), N'Level 2', 35, N'Improving pacing', CAST(N'2025-11-27T11:43:04.9528062' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'ad83ea7c-64a0-407f-a68f-5ca4b2428ed4', N'0ba08e95-a0c7-4a41-aa48-9778f87188e1', N'253f63ce-5a1e-4015-af4a-08de2daa1c9d', N'690ccd85-2c9d-47aa-a093-c98b0bb2d05e', CAST(N'2024-10-07' AS Date), N'Level 4', 40, N'Working on tone', CAST(N'2025-11-27T11:43:04.9528516' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'1c9685ba-fbc3-4b80-9f84-6410cd9d60e9', N'8c08b63c-1309-4c2e-aaf2-7ad983640d08', N'b8343aa7-26e1-4e21-af47-08de2daa1c9d', N'dcfdcf99-0b38-4bc6-a4af-49b9a3ca9380', CAST(N'2024-09-16' AS Date), N'Level 3', 40, N'Great focus', CAST(N'2025-11-27T11:43:04.9528099' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'2ac03c87-7565-4602-82d6-659666e45904', N'09cc3d59-73b4-4268-a34d-e3a081cd1c57', N'df69c88c-ee7c-475d-af45-08de2daa1c9d', N'38e720da-09e6-409b-8815-7ac839290fd0', CAST(N'2024-09-02' AS Date), N'Level 1', 30, N'Needs vowel practice', CAST(N'2025-11-27T11:43:04.9528011' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'cb82a5dc-6e4b-47b5-873f-85263c96ce58', N'cc533d8b-e3ad-47f2-9de9-33faba53d9c6', N'b8343aa7-26e1-4e21-af47-08de2daa1c9d', N'ef5a7516-7322-4156-b9c8-173c86b87574', CAST(N'2024-09-16' AS Date), N'Level 4', 60, N'Confident narrator', CAST(N'2025-11-27T11:43:04.9528076' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'3cf3f396-856a-4b50-8ed0-89c73fa95c98', N'bac5656e-935b-4b94-9fa8-ae9725eba9e5', N'253f63ce-5a1e-4015-af4a-08de2daa1c9d', N'ea4b742e-7564-4224-b330-cff1f9b8a0e2', CAST(N'2024-10-07' AS Date), N'Level 4', 55, N'Detailed observations', CAST(N'2025-11-27T11:43:04.9528526' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'951d86c8-d056-4dfa-90c7-8b09e15e7fac', N'8b88d802-70e4-4d99-b036-0f204004b0c9', N'164a7ab3-9f76-47fd-af46-08de2daa1c9d', N'fc936710-64f2-4f4a-8e9c-4f006ee982eb', CAST(N'2024-09-09' AS Date), N'Level 3', 50, N'Excellent comprehension', CAST(N'2025-11-27T11:43:04.9528050' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'48e4fd5e-f575-4a33-bd97-a2df21c51e20', N'fbe5df14-7867-4d12-84ed-296e6648333a', N'189fc27f-7311-4ba9-af4b-08de2daa1c9d', N'b1be2588-a44a-453f-bf90-3f39a0895d04', CAST(N'2024-10-14' AS Date), N'Level 5', 65, N'Engages classmates', CAST(N'2025-11-27T11:43:04.9528535' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'e676b593-9d94-40c3-b195-a55b52e355e9', N'50609994-6eac-4d02-86dd-d54a62e7c454', N'9c66667a-e0f1-4031-af4d-08de2daa1c9d', N'1b855a93-fe53-4bf4-9d7f-63bd60c8f9cf', CAST(N'2024-10-21' AS Date), N'Level 6', 50, N'Great critical thinking', CAST(N'2025-11-27T11:43:04.9528556' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'6d3a9d64-aeca-4bcc-b6ed-ae9f69864fcd', N'99d684d9-72cb-414a-9cdf-65bbe4d3ccdd', N'12be97a2-6d1d-444b-af48-08de2daa1c9d', N'c28f2745-a990-410a-a9a5-05728724ace0', CAST(N'2024-09-23' AS Date), N'Level 5', 55, N'Powerful expression', CAST(N'2025-11-27T11:43:04.9528110' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'4849f9c6-2973-438f-814a-e3856c0f87b6', N'3cef9d40-a8d4-47ed-9e7a-7f4ab3022e44', N'99895339-15de-48bd-af49-08de2daa1c9d', N'568805b5-81e6-4aea-94f6-2733fff6552e', CAST(N'2024-09-30' AS Date), N'Level 6', 70, N'Leadership in group reading', CAST(N'2025-11-27T11:43:04.9528476' AS DateTime2), NULL)
GO
INSERT [dbo].[ReadingProgress] ([Id], [StudentId], [TeacherId], [BookId], [WeekStartDate], [ReadingLevel], [DurationMinutes], [Notes], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'f7db0480-5b92-45c0-a793-f7768607ff37', N'5d2a8033-372a-4467-984b-9d3eae6a8a44', N'df69c88c-ee7c-475d-af45-08de2daa1c9d', N'3908033b-8577-469e-8231-03b4d31ad9c0', CAST(N'2024-09-02' AS Date), N'Level 2', 45, N'Strong fluency', CAST(N'2025-11-27T11:43:04.9521863' AS DateTime2), NULL)
GO
INSERT [dbo].[ReportCaches] ([Id], [ReportType], [ScopeId], [PeriodStart], [PeriodEnd], [PayloadJson], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'6fa69a9f-5fdc-4660-99db-700e1622fb49', N'Dashboard', NULL, CAST(N'2025-11-27' AS Date), CAST(N'2025-11-27' AS Date), N'{"TotalStudents":15,"ActiveStudents":15,"TotalReadingRecords":15,"TotalReadingMinutes":750,"CurrentTermMinutes":0,"ReadingLevelDistribution":{"Mustawa 4":4,"Mustawa 5":3,"Mustawa 6":3,"Mustawa 2":2,"Mustawa 3":2,"Mustawa 1":1},"ClassSummaries":[{"ClassId":"aeabbcc9-cde9-4f3d-a023-0738490371b9","ClassName":"Fasl 5A","StudentCount":1,"RecordCount":1,"TotalMinutes":60,"AverageReadingLevel":"Mustawa 6"},{"ClassId":"ed2a4a84-0748-4df8-8e1a-09f3d15db3a2","ClassName":"Fasl 1C","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"2b82b498-fc77-4f90-a0d5-16038dc75a9e","ClassName":"Fasl 4C","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"90e9f7ce-c0fd-41ea-9c73-188bf399ced3","ClassName":"Fasl 2A","StudentCount":2,"RecordCount":2,"TotalMinutes":100,"AverageReadingLevel":"Mustawa 3"},{"ClassId":"54ed37b4-2474-47eb-8942-370b78c7621a","ClassName":"Fasl 5C","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"a944131b-db4d-4914-b96a-512be08b9305","ClassName":"Fasl 4A","StudentCount":1,"RecordCount":1,"TotalMinutes":65,"AverageReadingLevel":"Mustawa 5"},{"ClassId":"52961bae-01a1-4e8b-9279-5af7740bc4eb","ClassName":"Fasl 3C","StudentCount":1,"RecordCount":1,"TotalMinutes":55,"AverageReadingLevel":"Mustawa 4"},{"ClassId":"bd3560b9-4e20-4955-a64f-5ea7927efe51","ClassName":"Fasl 1B","StudentCount":2,"RecordCount":2,"TotalMinutes":85,"AverageReadingLevel":"Mustawa 2"},{"ClassId":"04b86bd2-9a0f-442a-bf32-69f4f801a1ab","ClassName":"Fasl 2C","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"a63afedc-2f49-4d86-af84-98f6b0dfdf81","ClassName":"Fasl 2B","StudentCount":2,"RecordCount":2,"TotalMinutes":100,"AverageReadingLevel":"Mustawa 4"},{"ClassId":"19dcdaf0-63a8-428c-8f02-b84553abf244","ClassName":"Fasl 1A","StudentCount":2,"RecordCount":2,"TotalMinutes":75,"AverageReadingLevel":"Mustawa 1"},{"ClassId":"907edcd6-74f5-48d7-8a47-d184103861aa","ClassName":"Fasl 4B","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"61224290-de1d-416a-8d42-dbb10c535578","ClassName":"Fasl 3A","StudentCount":2,"RecordCount":2,"TotalMinutes":120,"AverageReadingLevel":"Mustawa 5"},{"ClassId":"e0a62056-2abe-42fe-9ec1-eb8a473e027f","ClassName":"Fasl 3B","StudentCount":1,"RecordCount":1,"TotalMinutes":40,"AverageReadingLevel":"Mustawa 4"},{"ClassId":"a4287f3c-9ec1-45c0-970a-f271be6d1fc4","ClassName":"Fasl 5B","StudentCount":1,"RecordCount":1,"TotalMinutes":50,"AverageReadingLevel":"Mustawa 6"}],"MissingEntries":[{"StudentId":"8b88d802-70e4-4d99-b036-0f204004b0c9","StudentName":"Mohammed Al-Hajri","ClassName":"Fasl 1B","WeekStart":"2025-11-24"},{"StudentId":"58d62c5f-138d-4268-be2b-17c81b3e6622","StudentName":"Layla Abdullah","ClassName":"Fasl 3A","WeekStart":"2025-11-24"},{"StudentId":"fbe5df14-7867-4d12-84ed-296e6648333a","StudentName":"Sami Al-Qattan","ClassName":"Fasl 4A","WeekStart":"2025-11-24"},{"StudentId":"cc533d8b-e3ad-47f2-9de9-33faba53d9c6","StudentName":"Ali Al-Hasan","ClassName":"Fasl 2A","WeekStart":"2025-11-24"},{"StudentId":"99d684d9-72cb-414a-9cdf-65bbe4d3ccdd","StudentName":"Hamad Al-Kaabi","ClassName":"Fasl 2B","WeekStart":"2025-11-24"},{"StudentId":"8c08b63c-1309-4c2e-aaf2-7ad983640d08","StudentName":"Noura Al-Subaie","ClassName":"Fasl 2A","WeekStart":"2025-11-24"},{"StudentId":"3cef9d40-a8d4-47ed-9e7a-7f4ab3022e44","StudentName":"Omar Al-Khayyat","ClassName":"Fasl 3A","WeekStart":"2025-11-24"},{"StudentId":"0ba08e95-a0c7-4a41-aa48-9778f87188e1","StudentName":"Yassin Al-Saffar","ClassName":"Fasl 3B","WeekStart":"2025-11-24"},{"StudentId":"5d2a8033-372a-4467-984b-9d3eae6a8a44","StudentName":"Ahmad Al-Hammadi","ClassName":"Fasl 1A","WeekStart":"2025-11-24"},{"StudentId":"bac5656e-935b-4b94-9fa8-ae9725eba9e5","StudentName":"Hiba Al-Jabri","ClassName":"Fasl 3C","WeekStart":"2025-11-24"},{"StudentId":"c5b8cbcc-6f3c-4f30-82e5-c07c99f88910","StudentName":"Dana Al-Naimi","ClassName":"Fasl 5A","WeekStart":"2025-11-24"},{"StudentId":"2dd6c316-53fa-41cd-9db7-ce884156eda6","StudentName":"Sara Al-Mousa","ClassName":"Fasl 1B","WeekStart":"2025-11-24"},{"StudentId":"50609994-6eac-4d02-86dd-d54a62e7c454","StudentName":"Rakan Al-Mutlaq","ClassName":"Fasl 5B","WeekStart":"2025-11-24"},{"StudentId":"5e2de917-3848-4417-bdaf-e14addac0c4c","StudentName":"Maryam Al-Awadi","ClassName":"Fasl 2B","WeekStart":"2025-11-24"},{"StudentId":"09cc3d59-73b4-4268-a34d-e3a081cd1c57","StudentName":"Fatimah Al-Khalifa","ClassName":"Fasl 1A","WeekStart":"2025-11-24"}]}', CAST(N'2025-11-27T11:43:19.0153291' AS DateTime2), NULL)
GO
INSERT [dbo].[ReportCaches] ([Id], [ReportType], [ScopeId], [PeriodStart], [PeriodEnd], [PayloadJson], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'6b466a3c-1e96-4abc-9450-9ab811ae55fa', N'Dashboard', NULL, CAST(N'2025-11-27' AS Date), CAST(N'2025-11-27' AS Date), N'{"TotalStudents":15,"ActiveStudents":15,"TotalReadingRecords":15,"TotalReadingMinutes":750,"CurrentTermMinutes":0,"ReadingLevelDistribution":{"Level 4":4,"Level 5":3,"Level 6":3,"Level 2":2,"Level 3":2,"Level 1":1},"ClassSummaries":[{"ClassId":"aeabbcc9-cde9-4f3d-a023-0738490371b9","ClassName":"Class 5A","StudentCount":1,"RecordCount":1,"TotalMinutes":60,"AverageReadingLevel":"Level 6"},{"ClassId":"ed2a4a84-0748-4df8-8e1a-09f3d15db3a2","ClassName":"Class 1C","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"2b82b498-fc77-4f90-a0d5-16038dc75a9e","ClassName":"Class 4C","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"90e9f7ce-c0fd-41ea-9c73-188bf399ced3","ClassName":"Class 2A","StudentCount":2,"RecordCount":2,"TotalMinutes":100,"AverageReadingLevel":"Level 3"},{"ClassId":"54ed37b4-2474-47eb-8942-370b78c7621a","ClassName":"Class 5C","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"a944131b-db4d-4914-b96a-512be08b9305","ClassName":"Class 4A","StudentCount":1,"RecordCount":1,"TotalMinutes":65,"AverageReadingLevel":"Level 5"},{"ClassId":"52961bae-01a1-4e8b-9279-5af7740bc4eb","ClassName":"Class 3C","StudentCount":1,"RecordCount":1,"TotalMinutes":55,"AverageReadingLevel":"Level 4"},{"ClassId":"bd3560b9-4e20-4955-a64f-5ea7927efe51","ClassName":"Class 1B","StudentCount":2,"RecordCount":2,"TotalMinutes":85,"AverageReadingLevel":"Level 2"},{"ClassId":"04b86bd2-9a0f-442a-bf32-69f4f801a1ab","ClassName":"Class 2C","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"a63afedc-2f49-4d86-af84-98f6b0dfdf81","ClassName":"Class 2B","StudentCount":2,"RecordCount":2,"TotalMinutes":100,"AverageReadingLevel":"Level 4"},{"ClassId":"19dcdaf0-63a8-428c-8f02-b84553abf244","ClassName":"Class 1A","StudentCount":2,"RecordCount":2,"TotalMinutes":75,"AverageReadingLevel":"Level 1"},{"ClassId":"907edcd6-74f5-48d7-8a47-d184103861aa","ClassName":"Class 4B","StudentCount":0,"RecordCount":0,"TotalMinutes":0,"AverageReadingLevel":"N/A"},{"ClassId":"61224290-de1d-416a-8d42-dbb10c535578","ClassName":"Class 3A","StudentCount":2,"RecordCount":2,"TotalMinutes":120,"AverageReadingLevel":"Level 5"},{"ClassId":"e0a62056-2abe-42fe-9ec1-eb8a473e027f","ClassName":"Class 3B","StudentCount":1,"RecordCount":1,"TotalMinutes":40,"AverageReadingLevel":"Level 4"},{"ClassId":"a4287f3c-9ec1-45c0-970a-f271be6d1fc4","ClassName":"Class 5B","StudentCount":1,"RecordCount":1,"TotalMinutes":50,"AverageReadingLevel":"Level 6"}],"MissingEntries":[{"StudentId":"8b88d802-70e4-4d99-b036-0f204004b0c9","StudentName":"Mohammed Al-Hajri","ClassName":"Class 1B","WeekStart":"2025-11-24"},{"StudentId":"58d62c5f-138d-4268-be2b-17c81b3e6622","StudentName":"Layla Abdullah","ClassName":"Class 3A","WeekStart":"2025-11-24"},{"StudentId":"fbe5df14-7867-4d12-84ed-296e6648333a","StudentName":"Sami Al-Qattan","ClassName":"Class 4A","WeekStart":"2025-11-24"},{"StudentId":"cc533d8b-e3ad-47f2-9de9-33faba53d9c6","StudentName":"Ali Al-Hasan","ClassName":"Class 2A","WeekStart":"2025-11-24"},{"StudentId":"99d684d9-72cb-414a-9cdf-65bbe4d3ccdd","StudentName":"Hamad Al-Kaabi","ClassName":"Class 2B","WeekStart":"2025-11-24"},{"StudentId":"8c08b63c-1309-4c2e-aaf2-7ad983640d08","StudentName":"Noura Al-Subaie","ClassName":"Class 2A","WeekStart":"2025-11-24"},{"StudentId":"3cef9d40-a8d4-47ed-9e7a-7f4ab3022e44","StudentName":"Omar Al-Khayyat","ClassName":"Class 3A","WeekStart":"2025-11-24"},{"StudentId":"0ba08e95-a0c7-4a41-aa48-9778f87188e1","StudentName":"Yassin Al-Saffar","ClassName":"Class 3B","WeekStart":"2025-11-24"},{"StudentId":"5d2a8033-372a-4467-984b-9d3eae6a8a44","StudentName":"Ahmad Al-Hammadi","ClassName":"Class 1A","WeekStart":"2025-11-24"},{"StudentId":"bac5656e-935b-4b94-9fa8-ae9725eba9e5","StudentName":"Hiba Al-Jabri","ClassName":"Class 3C","WeekStart":"2025-11-24"},{"StudentId":"c5b8cbcc-6f3c-4f30-82e5-c07c99f88910","StudentName":"Dana Al-Naimi","ClassName":"Class 5A","WeekStart":"2025-11-24"},{"StudentId":"2dd6c316-53fa-41cd-9db7-ce884156eda6","StudentName":"Sara Al-Mousa","ClassName":"Class 1B","WeekStart":"2025-11-24"},{"StudentId":"50609994-6eac-4d02-86dd-d54a62e7c454","StudentName":"Rakan Al-Mutlaq","ClassName":"Class 5B","WeekStart":"2025-11-24"},{"StudentId":"5e2de917-3848-4417-bdaf-e14addac0c4c","StudentName":"Maryam Al-Awadi","ClassName":"Class 2B","WeekStart":"2025-11-24"},{"StudentId":"09cc3d59-73b4-4268-a34d-e3a081cd1c57","StudentName":"Fatimah Al-Khalifa","ClassName":"Class 1A","WeekStart":"2025-11-24"}]}', CAST(N'2025-11-27T12:45:26.9077652' AS DateTime2), NULL)
GO
INSERT [dbo].[Roles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'd718c45b-79b3-4691-ff60-08de2daa1c25', N'Coordinator', N'COORDINATOR', NULL)
GO
INSERT [dbo].[Roles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'f9d03e6a-95c2-4149-ff61-08de2daa1c25', N'Teacher', N'TEACHER', NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'8b88d802-70e4-4d99-b036-0f204004b0c9', N'ST003', N'Mohammed', N'Al-Hajri', N'Male', CAST(N'2009-11-08T00:00:00.0000000' AS DateTime2), N'bd3560b9-4e20-4955-a64f-5ea7927efe51', N'Level 3', N'Active', CAST(N'2025-11-27T11:43:04.5428012' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'58d62c5f-138d-4268-be2b-17c81b3e6622', N'ST010', N'Layla', N'Abdullah', N'Female', CAST(N'2007-08-25T00:00:00.0000000' AS DateTime2), N'61224290-de1d-416a-8d42-dbb10c535578', N'Level 5', N'Active', CAST(N'2025-11-27T12:33:35.8822218' AS DateTime2), CAST(N'2025-11-27T12:33:35.9925861' AS DateTime2))
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'fbe5df14-7867-4d12-84ed-296e6648333a', N'ST013', N'Sami', N'Al-Qattan', N'Male', CAST(N'2007-12-19T00:00:00.0000000' AS DateTime2), N'a944131b-db4d-4914-b96a-512be08b9305', N'Level 5', N'Active', CAST(N'2025-11-27T11:43:04.5428170' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'cc533d8b-e3ad-47f2-9de9-33faba53d9c6', N'ST005', N'Ali', N'Al-Hasan', N'Male', CAST(N'2009-09-30T00:00:00.0000000' AS DateTime2), N'90e9f7ce-c0fd-41ea-9c73-188bf399ced3', N'Level 4', N'Active', CAST(N'2025-11-27T11:43:04.5428041' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'99d684d9-72cb-414a-9cdf-65bbe4d3ccdd', N'ST007', N'Hamad', N'Al-Kaabi', N'Male', CAST(N'2009-12-05T00:00:00.0000000' AS DateTime2), N'a63afedc-2f49-4d86-af84-98f6b0dfdf81', N'Level 5', N'Active', CAST(N'2025-11-27T11:43:04.5428071' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'8c08b63c-1309-4c2e-aaf2-7ad983640d08', N'ST006', N'Noura', N'Al-Subaie', N'Female', CAST(N'2009-07-18T00:00:00.0000000' AS DateTime2), N'90e9f7ce-c0fd-41ea-9c73-188bf399ced3', N'Level 3', N'Active', CAST(N'2025-11-27T12:34:17.1107027' AS DateTime2), CAST(N'2025-11-27T12:34:17.1118865' AS DateTime2))
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'3cef9d40-a8d4-47ed-9e7a-7f4ab3022e44', N'ST009', N'Omar', N'Al-Khayyat', N'Male', CAST(N'2008-10-12T00:00:00.0000000' AS DateTime2), N'61224290-de1d-416a-8d42-dbb10c535578', N'Level 6', N'Active', CAST(N'2025-11-27T11:43:04.5428100' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'0ba08e95-a0c7-4a41-aa48-9778f87188e1', N'ST011', N'Yassin', N'Al-Saffar', N'Male', CAST(N'2008-03-11T00:00:00.0000000' AS DateTime2), N'e0a62056-2abe-42fe-9ec1-eb8a473e027f', N'Level 4', N'Active', CAST(N'2025-11-27T11:43:04.5428141' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'5d2a8033-372a-4467-984b-9d3eae6a8a44', N'ST001', N'Ahmad', N'Al-Hammadi', N'Male', CAST(N'2010-01-15T00:00:00.0000000' AS DateTime2), N'19dcdaf0-63a8-428c-8f02-b84553abf244', N'Level 2', N'Active', CAST(N'2025-11-27T11:43:04.5403139' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'bac5656e-935b-4b94-9fa8-ae9725eba9e5', N'ST012', N'Hiba', N'Al-Jabri', N'Female', CAST(N'2008-06-27T00:00:00.0000000' AS DateTime2), N'52961bae-01a1-4e8b-9279-5af7740bc4eb', N'Level 4', N'Active', CAST(N'2025-11-27T11:43:04.5428155' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'c5b8cbcc-6f3c-4f30-82e5-c07c99f88910', N'ST014', N'Dana', N'Al-Naimi', N'Female', CAST(N'2007-10-07T00:00:00.0000000' AS DateTime2), N'aeabbcc9-cde9-4f3d-a023-0738490371b9', N'Level 6', N'Active', CAST(N'2025-11-27T11:43:04.5428184' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'2dd6c316-53fa-41cd-9db7-ce884156eda6', N'ST004', N'Sara', N'Al-Mousa', N'Female', CAST(N'2010-05-14T00:00:00.0000000' AS DateTime2), N'bd3560b9-4e20-4955-a64f-5ea7927efe51', N'Level 2', N'Active', CAST(N'2025-11-27T11:43:04.5428027' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'50609994-6eac-4d02-86dd-d54a62e7c454', N'ST015', N'Rakan', N'Al-Mutlaq', N'Male', CAST(N'2007-05-02T00:00:00.0000000' AS DateTime2), N'a4287f3c-9ec1-45c0-970a-f271be6d1fc4', N'Level 6', N'Active', CAST(N'2025-11-27T11:43:04.5428200' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'5e2de917-3848-4417-bdaf-e14addac0c4c', N'ST008', N'Maryam', N'Al-Awadi', N'Female', CAST(N'2009-04-20T00:00:00.0000000' AS DateTime2), N'a63afedc-2f49-4d86-af84-98f6b0dfdf81', N'Level 4', N'Active', CAST(N'2025-11-27T11:43:04.5428085' AS DateTime2), NULL)
GO
INSERT [dbo].[Students] ([Id], [StudentCode], [FirstName], [LastName], [Gender], [DateOfBirth], [ClassroomId], [ReadingLevel], [Status], [CreatedAtUtc], [UpdatedAtUtc]) VALUES (N'09cc3d59-73b4-4268-a34d-e3a081cd1c57', N'ST002', N'Fatimah', N'Al-Khalifa', N'Female', CAST(N'2010-03-22T00:00:00.0000000' AS DateTime2), N'19dcdaf0-63a8-428c-8f02-b84553abf244', N'Level 1', N'Active', CAST(N'2025-11-27T11:43:04.5427964' AS DateTime2), NULL)
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'9c66667a-e0f1-4031-af4d-08de2daa1c9d', N'aeabbcc9-cde9-4f3d-a023-0738490371b9')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'164a7ab3-9f76-47fd-af46-08de2daa1c9d', N'ed2a4a84-0748-4df8-8e1a-09f3d15db3a2')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'54eb46b8-a0c8-4c6f-af52-08de2daa1c9d', N'ed2a4a84-0748-4df8-8e1a-09f3d15db3a2')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'aba0ae4a-bac8-4410-af4c-08de2daa1c9d', N'2b82b498-fc77-4f90-a0d5-16038dc75a9e')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'164a7ab3-9f76-47fd-af46-08de2daa1c9d', N'90e9f7ce-c0fd-41ea-9c73-188bf399ced3')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'52ede591-4b21-4695-af50-08de2daa1c9d', N'90e9f7ce-c0fd-41ea-9c73-188bf399ced3')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'b3926af2-2f1c-4a7f-af4f-08de2daa1c9d', N'54ed37b4-2474-47eb-8942-370b78c7621a')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'253f63ce-5a1e-4015-af4a-08de2daa1c9d', N'a944131b-db4d-4914-b96a-512be08b9305')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'5b8a7392-95a1-4bea-af53-08de2daa1c9d', N'a944131b-db4d-4914-b96a-512be08b9305')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'99895339-15de-48bd-af49-08de2daa1c9d', N'52961bae-01a1-4e8b-9279-5af7740bc4eb')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'df69c88c-ee7c-475d-af45-08de2daa1c9d', N'bd3560b9-4e20-4955-a64f-5ea7927efe51')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'b8343aa7-26e1-4e21-af47-08de2daa1c9d', N'04b86bd2-9a0f-442a-bf32-69f4f801a1ab')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'b8343aa7-26e1-4e21-af47-08de2daa1c9d', N'a63afedc-2f49-4d86-af84-98f6b0dfdf81')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'df69c88c-ee7c-475d-af45-08de2daa1c9d', N'19dcdaf0-63a8-428c-8f02-b84553abf244')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'189fc27f-7311-4ba9-af4b-08de2daa1c9d', N'907edcd6-74f5-48d7-8a47-d184103861aa')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'12be97a2-6d1d-444b-af48-08de2daa1c9d', N'61224290-de1d-416a-8d42-dbb10c535578')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'18b6a056-24be-447e-af51-08de2daa1c9d', N'61224290-de1d-416a-8d42-dbb10c535578')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'99895339-15de-48bd-af49-08de2daa1c9d', N'e0a62056-2abe-42fe-9ec1-eb8a473e027f')
GO
INSERT [dbo].[TeacherClasses] ([TeacherId], [ClassroomId]) VALUES (N'1c631b53-a53b-48fb-af4e-08de2daa1c9d', N'a4287f3c-9ec1-45c0-970a-f271be6d1fc4')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'dd949d78-eec8-4bae-af44-08de2daa1c9d', N'd718c45b-79b3-4691-ff60-08de2daa1c25')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'df69c88c-ee7c-475d-af45-08de2daa1c9d', N'f9d03e6a-95c2-4149-ff61-08de2daa1c25')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'164a7ab3-9f76-47fd-af46-08de2daa1c9d', N'f9d03e6a-95c2-4149-ff61-08de2daa1c25')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'b8343aa7-26e1-4e21-af47-08de2daa1c9d', N'f9d03e6a-95c2-4149-ff61-08de2daa1c25')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'12be97a2-6d1d-444b-af48-08de2daa1c9d', N'f9d03e6a-95c2-4149-ff61-08de2daa1c25')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'99895339-15de-48bd-af49-08de2daa1c9d', N'f9d03e6a-95c2-4149-ff61-08de2daa1c25')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'253f63ce-5a1e-4015-af4a-08de2daa1c9d', N'f9d03e6a-95c2-4149-ff61-08de2daa1c25')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'189fc27f-7311-4ba9-af4b-08de2daa1c9d', N'f9d03e6a-95c2-4149-ff61-08de2daa1c25')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'aba0ae4a-bac8-4410-af4c-08de2daa1c9d', N'f9d03e6a-95c2-4149-ff61-08de2daa1c25')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'9c66667a-e0f1-4031-af4d-08de2daa1c9d', N'f9d03e6a-95c2-4149-ff61-08de2daa1c25')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'1c631b53-a53b-48fb-af4e-08de2daa1c9d', N'f9d03e6a-95c2-4149-ff61-08de2daa1c25')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'b3926af2-2f1c-4a7f-af4f-08de2daa1c9d', N'f9d03e6a-95c2-4149-ff61-08de2daa1c25')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'52ede591-4b21-4695-af50-08de2daa1c9d', N'f9d03e6a-95c2-4149-ff61-08de2daa1c25')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'18b6a056-24be-447e-af51-08de2daa1c9d', N'f9d03e6a-95c2-4149-ff61-08de2daa1c25')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'54eb46b8-a0c8-4c6f-af52-08de2daa1c9d', N'f9d03e6a-95c2-4149-ff61-08de2daa1c25')
GO
INSERT [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (N'5b8a7392-95a1-4bea-af53-08de2daa1c9d', N'f9d03e6a-95c2-4149-ff61-08de2daa1c25')
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'dd949d78-eec8-4bae-af44-08de2daa1c9d', N'System', N'Coordinator', N'Coordinator', 1, CAST(N'2025-11-27T11:42:57.8681231' AS DateTime2), NULL, N'coordinator', N'COORDINATOR', N'coordinator@dilmunreading.com', N'COORDINATOR@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEIYvV8EWTwZ68E+8rrD2Ju2zYURIUvEttayY/hvyFNAW2LKGUdBy+qyMwsBh9RthQw==', N'VARSJFYZZUM2SEYPSX7QIRLV4BJCJMPR', N'c18f91f0-087b-4a6d-8943-2e09c75912a2', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'df69c88c-ee7c-475d-af45-08de2daa1c9d', N'Ali', N'Mansoor', N'Teacher', 1, CAST(N'2025-11-27T11:42:58.7253076' AS DateTime2), NULL, N'teacher.ali', N'TEACHER.ALI', N'ali.mansoor@dilmunreading.com', N'ALI.MANSOOR@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEC1j6aoMte97G9Dm9td2Kx6kaKBOZkWkivKsFTVvxFy019jdxJ51xm3FJkF+//fZtA==', N'YVDQY5ERMHTWK3L3YQPVKOQJBPC32KVN', N'fba62697-07f5-4c2c-a21b-117a56bee411', N'+97333000001', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'164a7ab3-9f76-47fd-af46-08de2daa1c9d', N'Farah', N'Al-Qattan', N'Teacher', 1, CAST(N'2025-11-27T11:42:58.9962200' AS DateTime2), NULL, N'teacher.farah', N'TEACHER.FARAH', N'farah.qattan@dilmunreading.com', N'FARAH.QATTAN@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEM5Dpk/5eu0ecoA+lctOhsTvhZ3XghNV6lRFZaD6Er4c2GdrLhArr1g9TLnx0LBbjQ==', N'NHXRY5YCGP4VQT6HPZUI254EJGSZHKXU', N'75172769-368b-4780-b849-8247a1252007', N'+97333000002', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'b8343aa7-26e1-4e21-af47-08de2daa1c9d', N'Saad', N'Al-Noaimi', N'Teacher', 1, CAST(N'2025-11-27T11:42:59.2334381' AS DateTime2), NULL, N'teacher.saad', N'TEACHER.SAAD', N'saad.noaimi@dilmunreading.com', N'SAAD.NOAIMI@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAECH1exNXzoYCkAPDAorBiQcky5qIVhNyyiSrJriEgtQO9oqCUUaIq5eNs9Y0oVUxpQ==', N'BX5HVCCLTT2TZ2GMMRQU2SQXL44RJTUQ', N'83c1c086-a028-4dab-8a23-00fee5891e75', N'+97333000003', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'12be97a2-6d1d-444b-af48-08de2daa1c9d', N'Huda', N'Al-Khaldi', N'Teacher', 1, CAST(N'2025-11-27T11:42:59.4916760' AS DateTime2), NULL, N'teacher.huda', N'TEACHER.HUDA', N'huda.khaldi@dilmunreading.com', N'HUDA.KHALDI@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEEOhFuMXQdCUA1gj3Nx1E+qZRLeNyHEynfunPAmOmPjYdOhgCebpk2TB9g8hAxJwkg==', N'PISXRL3QDSYML2ZIBFOAQ56Z5WBWNXE2', N'5aa672df-d02f-4469-94e2-9446f94de37c', N'+97333000004', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'99895339-15de-48bd-af49-08de2daa1c9d', N'Malek', N'Al-Sabah', N'Teacher', 1, CAST(N'2025-11-27T11:42:59.7221165' AS DateTime2), NULL, N'teacher.malek', N'TEACHER.MALEK', N'malek.sabah@dilmunreading.com', N'MALEK.SABAH@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEDJlucVrjFUWqtL3tDhC8gEqHl5fE0Jlkd0v0l5bo13KeW5Qcs+35/5CvlKQe6JYgg==', N'WJHW4J2TTFCOM5YLGRZUH5OCNCGXY7EB', N'38bd300a-23a8-4e8b-8fe8-2d515670a889', N'+97333000005', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'253f63ce-5a1e-4015-af4a-08de2daa1c9d', N'Reem', N'Al-Ansari', N'Teacher', 1, CAST(N'2025-11-27T11:43:00.6501756' AS DateTime2), NULL, N'teacher.reem', N'TEACHER.REEM', N'reem.ansari@dilmunreading.com', N'REEM.ANSARI@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEM4MLcRIxiFAyy7NNJHJndE0vs/Z24QFWWSFcVaJG4ymjGWte8YIfM1xk7IuKwrW0w==', N'SSFOXPZWQV5GFKZC574VVE2SWDJHMZ3B', N'f951df0d-248c-4b40-984a-df7cf70acf88', N'+97333000006', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'189fc27f-7311-4ba9-af4b-08de2daa1c9d', N'Samer', N'Al-Sharif', N'Teacher', 1, CAST(N'2025-11-27T11:43:00.9794283' AS DateTime2), NULL, N'teacher.samer', N'TEACHER.SAMER', N'samer.sharif@dilmunreading.com', N'SAMER.SHARIF@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEPVvQzkkK8PjvsxnR9ZXtpKQVqUiTNZHlb/m4282wfnHlfvXYhkkJG7rvmE82659wg==', N'Q6ZUEBLKKNHVFPKLXMP5LWPRTEQ3J42M', N'e6aa64be-aea3-49c4-8b67-42f11b67c8df', N'+97333000007', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'aba0ae4a-bac8-4410-af4c-08de2daa1c9d', N'Lama', N'Al-Harthy', N'Teacher', 1, CAST(N'2025-11-27T11:43:01.2582750' AS DateTime2), NULL, N'teacher.lama', N'TEACHER.LAMA', N'lama.harthy@dilmunreading.com', N'LAMA.HARTHY@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEAnS7Ir8QHT5g8wAb2BcQhunGac4XmQUhuiLlKnj5Aw/7AgTY4wmcnX1f4eVK1Zcrg==', N'XXZ2NJOZSOWI4XWSAUPOWUX5MKND4SGY', N'1c72eee8-f434-46f8-9479-d4a0097eb27f', N'+97333000008', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'9c66667a-e0f1-4031-af4d-08de2daa1c9d', N'Yousef', N'Al-Rifai', N'Teacher', 1, CAST(N'2025-11-27T11:43:01.7854029' AS DateTime2), NULL, N'teacher.yousef', N'TEACHER.YOUSEF', N'yousef.rifai@dilmunreading.com', N'YOUSEF.RIFAI@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEKp50JA/QaeGkArgTeUmR7jhQahopqn08yaL32mjWOyI1v3bHHgnIyFoL02n/GPIIQ==', N'WRHZSOQAXPQISUYS3MN3RUCFLRCZQ5TU', N'df2979e2-1e7f-4b96-b7e8-f408a3c91abb', N'+97333000009', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'1c631b53-a53b-48fb-af4e-08de2daa1c9d', N'Basma', N'Al-Hassan', N'Teacher', 1, CAST(N'2025-11-27T11:43:02.0973362' AS DateTime2), NULL, N'teacher.basma', N'TEACHER.BASMA', N'basma.hassan@dilmunreading.com', N'BASMA.HASSAN@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEArVuW9I/HDNwa7fk/LVyHSU3Q3p9e9a6jhEEtbzDzn8CXvB8iQAdk7hRQWaZHHppw==', N'NSCYROUCJJVQEQQWYXMKIZD6PDM4PBB4', N'22e89fb4-03ad-436c-a35e-324efeeae102', N'+97333000010', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'b3926af2-2f1c-4a7f-af4f-08de2daa1c9d', N'Karim', N'Al-Saleh', N'Teacher', 1, CAST(N'2025-11-27T11:43:02.4060258' AS DateTime2), NULL, N'teacher.karim', N'TEACHER.KARIM', N'karim.saleh@dilmunreading.com', N'KARIM.SALEH@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEP61YEIUqyisUSHLsl03YeB1Bi8jBuW+pDHvqOdK380eJsZuPSBJ5pzi4vEhUGzg4g==', N'FYDKBHVDCQKWI7ZDYH5XE3G5PTTHNJRT', N'0293e11c-dd4a-48f6-8f02-fef620bfacc2', N'+97333000011', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'52ede591-4b21-4695-af50-08de2daa1c9d', N'Mona', N'Al-Tamimi', N'Teacher', 1, CAST(N'2025-11-27T11:43:02.7163893' AS DateTime2), NULL, N'teacher.mona', N'TEACHER.MONA', N'mona.tamimi@dilmunreading.com', N'MONA.TAMIMI@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEDycbEoFjxvHhgOCjHdm2Y5M13vk4QZBpx6Sac5r7yoo3YtMwsZa0Rcu1LD5sTM9xw==', N'A6TJL46CEXPXTJXSD34HVLT3PZANSSF6', N'62e8c3ac-2d71-4c9e-b624-3e6ecb6d6fad', N'+97333000012', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'18b6a056-24be-447e-af51-08de2daa1c9d', N'Sultan', N'Al-Zayani', N'Teacher', 1, CAST(N'2025-11-27T11:43:03.0924833' AS DateTime2), NULL, N'teacher.sultan', N'TEACHER.SULTAN', N'sultan.zayani@dilmunreading.com', N'SULTAN.ZAYANI@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEBJlQdV8uBx3AZKtg5xq4WSaonwjPomhihuNlZsVQMadGLJ5vWVmiqEd9lwX0s3uXg==', N'HOMPHMOTMQEMOMQ56Z55HVGULTAM7TGJ', N'2b2fdfac-1bc3-4e47-b402-3c2f0dfc578f', N'+97333000013', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'54eb46b8-a0c8-4c6f-af52-08de2daa1c9d', N'Nour', N'Al-Darwish', N'Teacher', 1, CAST(N'2025-11-27T11:43:03.4058551' AS DateTime2), NULL, N'teacher.nour', N'TEACHER.NOUR', N'nour.darwish@dilmunreading.com', N'NOUR.DARWISH@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEMaBsmNfCVQ7OR+zBKpriPW9wJp+9bmcI5yxhZLZ9KyraRY/1cpPuCnTLqK+JEJsng==', N'FXDXMWA2GWFSTHOGUWZQOBOGJIMBH2HU', N'209d4d31-099c-4c26-aac0-7b1e971e7fea', N'+97333000014', 1, 0, NULL, 1, 0)
GO
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Role], [IsActive], [CreatedAtUtc], [UpdatedAtUtc], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'5b8a7392-95a1-4bea-af53-08de2daa1c9d', N'Ayman', N'Al-Hadid', N'Teacher', 1, CAST(N'2025-11-27T11:43:03.8020513' AS DateTime2), NULL, N'teacher.ayman', N'TEACHER.AYMAN', N'ayman.hadid@dilmunreading.com', N'AYMAN.HADID@DILMUNREADING.COM', 1, N'AQAAAAIAAYagAAAAEIO/0OvxknI79aV9QYEGqniQFVcP5AxrIWki1FX+AuBNCE1GrI6qrDq+BztDXkgb+w==', N'GBNWCZZFWUJGS742MGF55Z46HWLRXUUW', N'a0bc0c50-0612-491f-a402-2df0925194db', N'+97333000015', 1, 0, NULL, 1, 0)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Books_Title_Author]    Script Date: 11/28/2025 2:26:50 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Books_Title_Author] ON [dbo].[Books]
(
	[Title] ASC,
	[Author] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Classrooms_Name]    Script Date: 11/28/2025 2:26:50 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Classrooms_Name] ON [dbo].[Classrooms]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ReadingProgress_BookId]    Script Date: 11/28/2025 2:26:50 PM ******/
CREATE NONCLUSTERED INDEX [IX_ReadingProgress_BookId] ON [dbo].[ReadingProgress]
(
	[BookId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ReadingProgress_StudentId_WeekStartDate]    Script Date: 11/28/2025 2:26:50 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ReadingProgress_StudentId_WeekStartDate] ON [dbo].[ReadingProgress]
(
	[StudentId] ASC,
	[WeekStartDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_ReportCaches_ReportType_ScopeId_PeriodStart_PeriodEnd]    Script Date: 11/28/2025 2:26:50 PM ******/
CREATE NONCLUSTERED INDEX [IX_ReportCaches_ReportType_ScopeId_PeriodStart_PeriodEnd] ON [dbo].[ReportCaches]
(
	[ReportType] ASC,
	[ScopeId] ASC,
	[PeriodStart] ASC,
	[PeriodEnd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_RoleClaims_RoleId]    Script Date: 11/28/2025 2:26:50 PM ******/
CREATE NONCLUSTERED INDEX [IX_RoleClaims_RoleId] ON [dbo].[RoleClaims]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 11/28/2025 2:26:50 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[Roles]
(
	[NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Students_ClassroomId_Status]    Script Date: 11/28/2025 2:26:50 PM ******/
CREATE NONCLUSTERED INDEX [IX_Students_ClassroomId_Status] ON [dbo].[Students]
(
	[ClassroomId] ASC,
	[Status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Students_StudentCode]    Script Date: 11/28/2025 2:26:50 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Students_StudentCode] ON [dbo].[Students]
(
	[StudentCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_TeacherClasses_ClassroomId]    Script Date: 11/28/2025 2:26:50 PM ******/
CREATE NONCLUSTERED INDEX [IX_TeacherClasses_ClassroomId] ON [dbo].[TeacherClasses]
(
	[ClassroomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserClaims_UserId]    Script Date: 11/28/2025 2:26:50 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserClaims_UserId] ON [dbo].[UserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserLogins_UserId]    Script Date: 11/28/2025 2:26:50 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserLogins_UserId] ON [dbo].[UserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserRoles_RoleId]    Script Date: 11/28/2025 2:26:50 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserRoles_RoleId] ON [dbo].[UserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [EmailIndex]    Script Date: 11/28/2025 2:26:50 PM ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[Users]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Users_UserName]    Script Date: 11/28/2025 2:26:50 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Users_UserName] ON [dbo].[Users]
(
	[UserName] ASC
)
WHERE ([UserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 11/28/2025 2:26:50 PM ******/
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
ALTER DATABASE [DilmunReadingDb] SET  READ_WRITE 
GO
