using System;
using newsApi.Entities;

namespace newsApi.Models;

public class BookmarkReturnDto
{
    public Guid Id { get; set; }
    public News New { get; set; } = new News();
}
