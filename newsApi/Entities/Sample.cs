using System;

namespace newsApi.Entities;


public class Sample()
{
    public Guid Id { get; set; }
    public string UserName { get; set; } = string.Empty;

    public string Role { get; set; } = string.Empty;
}