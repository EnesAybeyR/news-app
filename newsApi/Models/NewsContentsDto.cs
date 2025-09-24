using System;

namespace newsApi.Models;

public class NewsContentsDto
{
    public string Content { get; set; } = string.Empty;
    public int Order { get; set; } = 0;
    public string ContentType { get; set; } = string.Empty;

}
