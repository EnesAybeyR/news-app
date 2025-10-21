using System;
using newsApi.Entities;

namespace newsApi.Models;

public class NewsDto
{
    public string Headline { get; set; } = string.Empty;

    public string CountryName { get; set; } = string.Empty;

    public int? CategoryId { get; set; }

    public List<NewsContentsDto> NewsContentsDtos { get; set; } = new();

    public List<ImageDto> ImagesDtos { get; set; } = new();
}
