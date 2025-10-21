using System;

namespace newsApi.Entities;

public class LoginCode
{
    public int Id { get; set; }
    public string Username { get; set; } = string.Empty;
    public string Code { get; set; } = string.Empty;
    public DateTime ExpireAt { get; set; }
}
