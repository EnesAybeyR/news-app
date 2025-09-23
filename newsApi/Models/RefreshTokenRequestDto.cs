using System;

namespace newsApi.Models;

public class RefreshTokenRequestDto
{
    public required string Id { get; set; }
    public required string RefreshToken { get; set; }
}
