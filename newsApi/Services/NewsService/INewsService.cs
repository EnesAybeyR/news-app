using System;
using Microsoft.AspNetCore.Mvc;
using newsApi.Entities;
using newsApi.Models;

namespace newsApi.Services.NewsService;

public interface INewsService
{
    Task<News?> CreateNew(NewsDto request, Guid EditorId);
    Task<bool> DeleteNew(Guid newId);

    Task<List<News>> GetNewsAsync(int page =1, int pageSize = 10);
    Task<List<News>> GetNewsByCategoryAsync(int CategoryId);

    Task<String> GetEditorNameAsync(Guid EditorId);

    Task<NewsComments?> CreateNewCommentAsync(NewCommentDto request, Guid userId, Guid newId);

    Task<List<NewsComments>> GetAllCommentsAsync(Guid newId);

    Task<UserBookmarks> CreateBookMarkAsync(UserBookmarks bookmarks);
    Task<bool> DeleteBookmarkAsync(Guid bookmarkId);

    Task<List<BookmarkReturnDto>> GetUserBookmarksAsync(Guid userId);
    Task<List<News>> GetNewsByNameAsync(String newName);
}

