using System;

namespace newsApi.Models.Tokens;

public class RefreshTokenRequestDto
{

    public string Id { get; set; }
    public required string RefreshToken { get; set; }
}
