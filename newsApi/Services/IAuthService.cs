using System;
using newsApi.Entities;
using newsApi.Models;
using newsApi.Models.Tokens;

namespace newsApi.Services;

public interface IAuthService
{
    Task<Admin?> CreateAdminAsync(AdminDto request);
    Task<string?> AdminLoginAsync(AdminDto request);

    Task<bool?> CreateUserAsync(UserDto request);

    Task<bool?> UpdateUserMail(string mail, Guid userId, string password);
    Task<TokenResponseDto?> UserLoginAsync(UserDto request);

    Task<bool> UserLoginAsyncWithNfa(UserDto request);

    Task<bool?> VerifyLoginCodeAsync(string username,string code);

    Task<bool> IsNfaActive(string username);

    Task<TokenResponseDto?> RefreshTokensAsync(RefreshTokenRequestDto request);
    Task<bool> IsMailActive(string username);
}
