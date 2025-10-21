using System;

namespace newsApi.Entities;

public class NewsComments
{
    public Guid Id { get; set; }
    public string Comment { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; } = DateTime.Now;

    public Guid UserId { get; set; }
    public Guid NewId { get; set; }
}
