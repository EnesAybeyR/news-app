using System;
using System.Reflection.Metadata.Ecma335;
using System.Runtime.CompilerServices;
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
        new1.EntryCount = request.EntryCount;
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

    public async Task<String> GetEditorNameAsync(Guid EditorId)
    {
        var editor = await context.Admins.FirstOrDefaultAsync(c => c.Id == EditorId);
        var editorName = editor.Name + " " + editor.Surname;
        return editorName;
    }
    
}
