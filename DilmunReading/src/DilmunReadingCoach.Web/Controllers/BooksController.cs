using DilmunReadingCoach.Core.Entities;
using DilmunReadingCoach.Infrastructure.Data;
using DilmunReadingCoach.Web.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace DilmunReadingCoach.Web.Controllers;

[Authorize]
public class BooksController : Controller
{
    private readonly ApplicationDbContext _context;
    private readonly IAuditService _auditService;

    public BooksController(ApplicationDbContext context, IAuditService auditService)
    {
        _context = context;
        _auditService = auditService;
    }

    [Authorize(Roles = "Coordinator,Teacher")]
    public async Task<IActionResult> Index(string? searchTerm)
    {
        var query = _context.Books.AsQueryable();

        if (!string.IsNullOrWhiteSpace(searchTerm))
        {
            query = query.Where(b => 
                b.Title.Contains(searchTerm) || 
                b.Author.Contains(searchTerm) ||
                b.Category.Contains(searchTerm));
        }

        var books = await query.OrderBy(b => b.Title).ToListAsync();
        return View(books);
    }

    [Authorize(Roles = "Coordinator")]
    public IActionResult Create()
    {
        return View();
    }

    [HttpPost]
    [Authorize(Roles = "Coordinator")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Create(Book book)
    {
        if (ModelState.IsValid)
        {
            book.Id = Guid.NewGuid();
            book.CreatedAtUtc = DateTime.UtcNow;
            book.Status = "Available";
            _context.Books.Add(book);
            await _context.SaveChangesAsync();
            await LogAudit("Create", book.Id, "Book");
            return RedirectToAction(nameof(Index));
        }

        return View(book);
    }

    [Authorize(Roles = "Coordinator")]
    public async Task<IActionResult> Edit(Guid id)
    {
        var book = await _context.Books.FindAsync(id);
        if (book == null) return NotFound();

        return View(book);
    }

    [HttpPost]
    [Authorize(Roles = "Coordinator")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Edit(Book book)
    {
        if (ModelState.IsValid)
        {
            book.UpdatedAtUtc = DateTime.UtcNow;
            _context.Books.Update(book);
            await _context.SaveChangesAsync();
            await LogAudit("Update", book.Id, "Book");
            return RedirectToAction(nameof(Index));
        }

        return View(book);
    }

    [Authorize(Roles = "Coordinator")]
    public async Task<IActionResult> Delete(Guid id)
    {
        var book = await _context.Books.FindAsync(id);
        if (book == null) return NotFound();

        return View(book);
    }

    [HttpPost, ActionName("Delete")]
    [Authorize(Roles = "Coordinator")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> DeleteConfirmed(Guid id)
    {
        var book = await _context.Books.FindAsync(id);
        if (book != null)
        {
            book.Status = "Inactive";
            book.UpdatedAtUtc = DateTime.UtcNow;
            await _context.SaveChangesAsync();
            await LogAudit("Delete", id, "Book");
        }

        return RedirectToAction(nameof(Index));
    }

    private async Task LogAudit(string action, Guid entityId, string entity)
    {
        var userId = Guid.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);
        await _auditService.LogActionAsync(
            userId,
            action,
            entity,
            entityId,
            $"{action} {entity}",
            HttpContext.Connection.RemoteIpAddress?.ToString());
    }
}

