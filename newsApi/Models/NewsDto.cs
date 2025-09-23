using System;

namespace newsApi.Models;

public class NewsDto
{
    public string Headline { get; set; } = string.Empty;

    public string CountryName { get; set; } = string.Empty;

    public int EntryCount { get; set; } = 0;
    
}
