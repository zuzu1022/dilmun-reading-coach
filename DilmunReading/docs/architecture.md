## Dilmun Reading Coach System — Architecture Overview

### 1. Solution Structure
- `Presentation` layer: ASP.NET Core MVC app serving Razor views + REST-style endpoints for AJAX (future-ready for tablets). Uses responsive HTML/CSS/JS with a blue/white theme and touch-friendly components.
- `Application` layer: service classes orchestrating workflows (auth, reading progress, reports, backups). Enforces role-based security using ASP.NET Identity policies.
- `Domain` layer: entity models (students, staff, classes, books, reading progress, backups, logs) managed via Entity Framework Core.
- `Infrastructure` layer: SQL Server database (single catalog), EF migrations, PDF/Excel generators, scheduled backup job, logging providers, storage for backup files (Bahrain-hosted).

### 2. Core Modules & Responsibilities
- **Authentication & Security**
  - ASP.NET Identity (custom tables to match PDPL logging needs).
  - Username/password with salted hashing, HTTPS-only, lockout after 3 failures, 10-minute sliding session timeout.
  - Audit log captures login, logout, and CRUD actions with user + IP.
- **Student Management**
  - CRUD interfaces for coordinator; teachers get read-only filtered by classes.
  - Bulk CSV import with validation and duplicate prevention (StudentID unique).
- **Staff / Teacher Management**
  - Coordinator creates/edits teachers, assigns classes, deactivates accounts, approves password reset requests.
  - Prevent duplicate usernames; enforce per-role permissions.
- **Class & Book Catalogue**
  - Simple class reference data; book catalogue with title, author, reading level, category, status.
  - Soft deletes (Status field) for auditability.
- **Reading Progress Tracking**
  - Weekly entries per student with reading level, duration (minutes), linked book, notes, and teacher reference.
  - Validation blocks duplicate week/student entries; editable history view.
- **Dashboards**
  - Coordinator dashboard: total students, records, reading level distribution, class summaries, total reading time per term, missing entries.
  - Teacher dashboard: assigned classes only, last reading level, missing entries, total minutes, quick links to add entries.
  - Cached aggregates + background refresh to keep <3s load time.
- **Reporting & Exports**
  - Weekly and term-end reports generated server-side with selectable date ranges; export to PDF (QuestPDF or Syncfusion) and Excel (EPPlus).
  - Coordinator can run school-wide exports; teachers scoped to their classes.
- **Backup & Restore**
  - Daily scheduled backup job (SQL Server Agent or Windows Task) writing encrypted .bak files to Bahrain-based storage.
  - Manual backup trigger + restore workflow (restricted to coordinator) with status page and log entries.
- **Logging & Compliance**
  - Central log table storing logins, logouts, add/edit/delete actions; retained 6 months.
  - All data, backups, and logs remain on Bahrain-hosted infrastructure.
  - Access control enforced at controller/service level to ensure teachers only see their data.

### 3. High-Level Data Flow
1. Users authenticate via HTTPS; Identity issues secure cookies with 10-minute idle timeout.
2. Authorized requests hit MVC controllers -> application services -> EF repositories.
3. Reading progress submissions validate business rules (duplicates, ownership) before persisting.
4. Dashboards and reports use cached aggregates plus on-demand SQL views/stored procedures to meet KPI load times.
5. Background backup job writes to secure storage; UI exposes status + manual triggers.
6. Logging middleware records user/IP/timestamp for auth events and CRUD actions.

### 4. External Interfaces & Future-Proofing
- REST API layer planned for Phase 2 will reuse the application services; database schema designed with stable GUID primary keys and audit fields to support API tokens later.
- PDF/Excel export services abstracted to allow swapping libraries without touching controllers.

### 5. Performance & Availability Strategies
- Connection pooling + async EF calls to support concurrent teachers.
- Database indexes on StudentID, ClassID, ReadingWeek, and BookID for fast queries.
- Output caching on dashboard/report endpoints with cache busting on new data.
- Health checks + logging to monitor uptime (99% school hours target) and backup success.

### 6. Security & Compliance Highlights
- HTTPS enforced via HSTS; no mixed content.
- Password policies + salted hashing (PBKDF2 via ASP.NET Identity).
- Lockout after 3 failed attempts; manual unlock by coordinator.
- Session auto-logout after 10 minutes inactivity with warning prompt.
- Data residency ensured by hosting + encrypted backups stored locally.
- Logs retained 6 months, then archived securely.

