using System;

namespace newsApi.Entities;

public class Image
{
    public Guid Id { get; set; }
    public string ImageName { get; set; } = string.Empty;
    public string ImagePath { get; set; } = string.Empty;
    public string Alt { get; set; } = string.Empty;
    public int Order { get; set; } = 1;

    public Guid NewId { get; set; }
    
}