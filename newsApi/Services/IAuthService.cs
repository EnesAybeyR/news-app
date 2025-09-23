using System;
using newsApi.Entities;
using newsApi.Models;

namespace newsApi.Services;

public interface IAuthService
{
    Task<Admin?> CreateAdminAsync(AdminDto request);
    Task<string?> AdminLoginAsync(AdminDto request);
}
