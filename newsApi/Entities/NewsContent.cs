using System;

namespace newsApi.Entities;

public class NewsContent
{
    public Guid Id { get; set; }
    public string Content { get; set; } = string.Empty;
    public int Order { get; set; } = 0;
    public string ContentType { get; set; } = string.Empty;
    public Guid NewId { get; set; }
}