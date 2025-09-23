using System;
using newsApi.Entities;
using newsApi.Models;

namespace newsApi.Services.NewsService;

public interface INewsService
{
    Task<News?> CreateNew(NewsDto request,int CategoryId,Guid EditorId);
}
