using System;
using Microsoft.AspNetCore.Authentication.BearerToken;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Identity;
using System.Security.Claims;
using Microsoft.EntityFrameworkCore;

using newsApi.Data;
using newsApi.Entities;
using newsApi.Models;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Cryptography;
using newsApi.Models.Tokens;
using FluentEmail.Core;
using SQLitePCL;

namespace newsApi.Services
{

    public class AuthService(AppDbContext context, IConfiguration configuration, IFluentEmail fluentEmail) : IAuthService
    {
        private readonly IFluentEmail _fluentEmail = fluentEmail;

        
        public async Task<Admin?> CreateAdminAsync(AdminDto request)
        {
            if (await context.Admins.AnyAsync(a => a.UserName == request.UserName))
            {
                return null;
            }
            var admin = new Admin();
            var hashedPassword = new PasswordHasher<Admin>().HashPassword(admin, request.Password);
            admin.UserName = request.UserName;
            admin.HashedPassword = hashedPassword;

            context.Admins.Add(admin);
            await context.SaveChangesAsync();
            return admin;
        }
        public async Task<string?> AdminLoginAsync(AdminDto request)
        {
            var admin = await context.Admins.FirstOrDefaultAsync(a => a.UserName == request.UserName);
            if (admin == null)
            {
                return null;
            }
            if (new PasswordHasher<Admin>().VerifyHashedPassword(admin, admin.HashedPassword, request.Password) == PasswordVerificationResult.Failed)
            {
                return null;
            }
            var user = new Sample();
            user.UserName = admin.UserName;
            user.Role = admin.Role;
            user.Id = admin.Id;
            var response = CreateToken(user);

            return response;
        }

        public async Task<bool?> CreateUserAsync(UserDto request)
        {
            
            if (await context.Users.AnyAsync(a => a.UserName == request.UserName)){
                return false;
            }
            var user = new User();
            var hashed_password = new PasswordHasher<User>().HashPassword(user, request.Password);
            user.UserName = request.UserName;
            user.HashedPassword = hashed_password;
            context.Users.Add(user);
            await context.SaveChangesAsync();
            return true;
        }

        public async Task<TokenResponseDto?> UserLoginAsync(UserDto request)
        {
            var user = await context.Users.FirstOrDefaultAsync(a => a.UserName == request.UserName);
            if (user == null)
            {
                return null;
            }
            if (new PasswordHasher<User>().VerifyHashedPassword(user, user.HashedPassword, request.Password) == PasswordVerificationResult.Failed)
            {
                return null;
            }
            var sample = new Sample();
            sample.UserName = user.UserName;
            sample.Role = user.Role;
            sample.Id = user.Id;
            var response = new TokenResponseDto
            {
                AccessToken = CreateToken(sample),
                RefreshToken = await GenerateAndSaveRefreshTokenAsync(user),
                UserId = sample.Id,
            };
            return response;
        }
        public async Task<bool> UserLoginAsyncWithNfa(UserDto request)
        {
            var user = await context.Users.FirstOrDefaultAsync(a => a.UserName == request.UserName);
            if (user == null)
            {
                return false;
            }
            if (new PasswordHasher<User>().VerifyHashedPassword(user, user.HashedPassword, request.Password) == PasswordVerificationResult.Failed)
            {
                return false;
            }
            return true;
        }
        
        public async Task<bool?> UpdateUserMail(string mail,Guid userId,string password)
        {
            var user = await context.Users.FirstOrDefaultAsync(a => a.Id == userId);
            if (user == null)
            {
                return null;
            }
            if (new PasswordHasher<User>().VerifyHashedPassword(user, user.HashedPassword, password) == PasswordVerificationResult.Failed)
            {
                return null;
            }
            var maill = await context.Users.FirstOrDefaultAsync(a => a.Email == mail);
            if(maill != null)
            {
                return false;
            }
            user.Email = mail;
            await context.SaveChangesAsync();
            return true;
        }

        public async Task<TokenResponseDto?> RefreshTokensAsync(RefreshTokenRequestDto request)
        {
            var user = await ValidateRefreshTokenAsync(request.Id, request.RefreshToken);
            if (user is null)
            {
                return null;
            }
            var sample = new Sample();
            sample.UserName = user.UserName;
            sample.Role = user.Role;
            sample.Id = user.Id;

            var response = new TokenResponseDto
            {
                AccessToken = CreateToken(sample),
                RefreshToken = await GenerateAndSaveRefreshTokenAsync(user),
                UserId = sample.Id,
            };
            return response;
        }

        private string GenerateResreshToken()
        {
            var randomNumber = new byte[32];
            RandomNumberGenerator.Fill(randomNumber);
            return Convert.ToBase64String(randomNumber);
        }

        private async Task<string> GenerateAndSaveRefreshTokenAsync(User user)
        {
            var refreshToken = GenerateResreshToken();
            user.RefreshToken = refreshToken;
            user.RefreshTokenExpiryTime = DateTime.UtcNow.AddDays(7);
            await context.SaveChangesAsync();
            return refreshToken;
        }

        private async Task<User?> ValidateRefreshTokenAsync(String userId, string refreshToken)
        {
            var user = await context.Users.FindAsync(Guid.Parse(userId));
            if (user == null || user.RefreshToken != refreshToken || user.RefreshTokenExpiryTime <= DateTime.UtcNow)
            {
                return null;
            }
            return user;
        }


        private string CreateToken(Sample user)
        {
            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.Name,user.UserName),
                new Claim(ClaimTypes.NameIdentifier,user.Id.ToString()),
                new Claim(ClaimTypes.Role,user.Role)
            };
            var secret = Environment.GetEnvironmentVariable("TOKEN");
            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secret));

            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha512);

            var tokenDescriptor = new JwtSecurityToken(
                issuer: Environment.GetEnvironmentVariable("ISSUER"),
                audience: Environment.GetEnvironmentVariable("AUDIENCE"),
                claims: claims,
                expires: DateTime.UtcNow.AddDays(1),
                signingCredentials: creds
            );
            return new JwtSecurityTokenHandler().WriteToken(tokenDescriptor);
        }

        public async Task<bool> IsNfaActive(string username)
        {
            var user = await context.Users.FirstOrDefaultAsync(u => u.UserName == username);
            if (user == null)
            {
                return false;
            }

            if (user.Email == null || user.Email.Length == 0 || user.Email == string.Empty)
            {
                return false;
            }
            bool x = await getNfa(user);
            return x;
        }
        public async Task<bool> IsMailActive(string username)
        {
            var user = await context.Users.FirstOrDefaultAsync(u => u.UserName == username);
            if (user == null)
            {
                return false;
            }

            if (user.Email == null || user.Email.Length == 0 || user.Email == string.Empty)
            {
                return false;
            }

            return true;
        }
        public async Task<bool> getNfa(User user){
            var code = new Random().Next(100000, 999999).ToString();

            var loginCode = new LoginCode
            {
                Username = user.UserName,
                Code = code,
                ExpireAt = DateTime.UtcNow.AddMinutes(5),
            };
            var prev = await context.LoginCodes.Where(u => u.Username == user.UserName).ToListAsync();
            if (prev.Any())
            {
                context.LoginCodes.RemoveRange(prev);
            }
            context.LoginCodes.Add(loginCode);
            await context.SaveChangesAsync();

            await _fluentEmail.To(user.Email).Subject("Login Code").Body($"Hello {user.UserName}, code is {code}").SendAsync();
            return true;
        }

        public async Task<bool?> VerifyLoginCodeAsync(string username,string code)
        {
            var loginCode = await context.LoginCodes.Where(u => u.Username == username && u.Code == code).FirstOrDefaultAsync();
            if (loginCode == null)
            {
                return false;
            }
            if (loginCode.ExpireAt < DateTime.UtcNow)
            {
                context.LoginCodes.Remove(loginCode);
                await context.SaveChangesAsync();
                return false;
            }

            await context.SaveChangesAsync();
            return true;
        }
    }
}