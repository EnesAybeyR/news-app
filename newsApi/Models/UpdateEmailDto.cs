using System;

namespace newsApi.Models;

public class UpdateEmailDto
{
    public string mail { get; set; } = String.Empty;
    public string password { get; set; } = String.Empty;
}
