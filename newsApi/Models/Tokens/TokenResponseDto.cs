using System;

namespace newsApi.Models.Tokens;

public class TokenResponseDto
{
    public required string AccessToken { get; set; }
    public required string RefreshToken { get; set; }

    public required Guid UserId { get; set; }
}
