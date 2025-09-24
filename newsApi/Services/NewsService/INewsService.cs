using System;
using Microsoft.AspNetCore.Mvc;
using newsApi.Entities;
using newsApi.Models;

namespace newsApi.Services.NewsService;

public interface INewsService
{
    Task<News?> CreateNew(NewsDto request, Guid EditorId);
    Task<bool> DeleteNew(Guid newId); 

    Task<List<News>> GetNewsAsync();
}
