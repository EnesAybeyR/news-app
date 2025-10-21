using System;

namespace newsApi.Models;

public class ImageDto
{
    public string ImageName { get; set; } = string.Empty;
    public string ImagePath { get; set; } = string.Empty;
    public string Alt { get; set; } = string.Empty;

    public int Order { get; set; } = 1;
}
