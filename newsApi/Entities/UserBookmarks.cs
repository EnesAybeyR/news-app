using System;

namespace newsApi.Entities;

public class UserBookmarks
{
    public Guid Id { get; set; }

    public Guid UserId { get; set; }

    public Guid NewId { get; set; }
}
