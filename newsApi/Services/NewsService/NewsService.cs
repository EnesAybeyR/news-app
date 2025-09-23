using System;
using System.Reflection.Metadata.Ecma335;
using System.Runtime.CompilerServices;
using Microsoft.AspNetCore.Http.HttpResults;
using newsApi.Data;
using newsApi.Entities;
using newsApi.Models;

namespace newsApi.Services.NewsService;

public class NewsService(AppDbContext context) : INewsService
{
    public async Task<News?> CreateNew(NewsDto request, int CategoryId, Guid EditorId)
    {
        var new1 = new News();        
        new1.Headline = request.Headline;
        new1.CountryName = request.CountryName;
        new1.EntryCount = request.EntryCount;
        new1.CategoryId = CategoryId;
        new1.EditorId = EditorId;
        context.News.Add(new1);
        await context.SaveChangesAsync();
        return new1;
    }
    
}
