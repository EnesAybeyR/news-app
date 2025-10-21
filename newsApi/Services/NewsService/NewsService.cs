using System;
using System.Reflection.Metadata.Ecma335;
using System.Runtime.CompilerServices;
using FluentEmail.Core;
using Microsoft.AspNetCore.Http.Features;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using newsApi.Data;
using newsApi.Entities;
using newsApi.Models;

namespace newsApi.Services.NewsService;

public class NewsService(AppDbContext context) : INewsService
{
    public async Task<News?> CreateNew(NewsDto request, Guid EditorId)
    {
        if (!await context.Categories.AnyAsync(c => c.Id == request.CategoryId))
        {
            return null;
        }
        var new1 = new News();
        new1.Headline = request.Headline;
        new1.CountryName = request.CountryName;
        new1.CategoryId = request.CategoryId;
        new1.EditorId = EditorId;

        new1.NewsContents = request.NewsContentsDtos.Select(c => new NewsContent
        {
            Content = c.Content,
            ContentType = c.ContentType,
            Order = c.Order,
        }).ToList();
        new1.Images = request.ImagesDtos.Select(i => new Image
        {
            ImageName = i.ImageName,
            ImagePath = i.ImagePath,
            Alt = i.Alt,
            Order = i.Order,

        }).ToList();
        context.News.Add(new1);
        await context.SaveChangesAsync();
        return new1;
    }


    public async Task<bool> DeleteNew(Guid newId)
    {
        var news = await context.News.FirstOrDefaultAsync(c => c.Id == newId);
        if (news == null)
        {
            return false;
        }
        context.Remove(news);
        await context.SaveChangesAsync();
        return true;

    }
    public async Task<List<News>> GetNewsAsync()
    {
        var news = await context.News.Include(c => c.Images).Include(c => c.NewsContents).ToListAsync();
        return news;
    }

    public async Task<List<News>> GetNewsByCategoryAsync(int CategoryId)
    {
        var news = await context.News.Include(c => c.Images).Include(c => c.NewsContents).Where(c => c.CategoryId == CategoryId).ToListAsync();
        return news;
    }
    public async Task<List<News>> GetNewsByNameAsync(String newName)
    {
        var result = await context.News.Include(c => c.Images).Include(c => c.NewsContents).Where(u => u.Headline.ToLower().Contains(newName.ToLower())).ToListAsync();
        return result;
    }

    public async Task<String> GetEditorNameAsync(Guid EditorId)
    {
        var editor = await context.Admins.FirstOrDefaultAsync(c => c.Id == EditorId);
        var editorName = editor.Name + " " + editor.Surname;
        return editorName;
    }

    public async Task<NewsComments?> CreateNewCommentAsync(NewCommentDto request, Guid userId, Guid newId)
    {
        var newComment = new NewsComments();
        newComment.Comment = request.Comment;
        newComment.UserId = userId;
        newComment.NewId = newId;
        context.NewsComments.Add(newComment);
        await context.SaveChangesAsync();
        return newComment;
    }

    public async Task<List<NewsComments>> GetAllCommentsAsync(Guid newId)
    {
        var comments = await context.NewsComments.Where(c => c.NewId == newId).ToListAsync();
        return comments;
    }

    public async Task<UserBookmarks> CreateBookMarkAsync(UserBookmarks bookmarks)

    {
        if (!await context.UserBookmarks.AnyAsync(c => c.Id == bookmarks.UserId&& c.NewId == bookmarks.NewId))
        {
            context.UserBookmarks.Add(bookmarks);
        await context.SaveChangesAsync();
        }
        
        return bookmarks;
    }
    public async Task<bool> DeleteBookmarkAsync(Guid bookmarkId)
    {
        var bookmark = await context.UserBookmarks.FirstOrDefaultAsync(u => u.Id == bookmarkId);
        if (bookmark == null)
        {
            return false;
        }
        context.UserBookmarks.Remove(bookmark);
        await context.SaveChangesAsync();
        return true;
    }

    public async Task<List<BookmarkReturnDto>> GetUserBookmarksAsync(Guid userId)
    {
        var userBookmarks = await context.UserBookmarks.Where(u => u.UserId == userId).ToListAsync();
        var result = new List<BookmarkReturnDto>();
        foreach (var bookmark in userBookmarks)
        {
            var news = await context.News.Include(c => c.Images).Include(c => c.NewsContents).FirstOrDefaultAsync(u => u.Id == bookmark.NewId);
            result.Add(new BookmarkReturnDto
            {
                Id = bookmark.Id,
                New = news
            });
        }
        return result;

    }
    
    
}
