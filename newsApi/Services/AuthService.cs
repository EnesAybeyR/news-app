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

namespace newsApi.Services
{

    public class AuthService(AppDbContext context, IConfiguration configuration) : IAuthService
    {
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
















        private string CreateToken(Sample user)
        {
            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.Name,user.UserName),
                new Claim(ClaimTypes.NameIdentifier,user.Id.ToString()),
                new Claim(ClaimTypes.Role,user.Role)
            };
            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(configuration.GetValue<string>("AppSettings:Token")!));

            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha512);

            var tokenDescriptor = new JwtSecurityToken(
                issuer: configuration.GetValue<string>("AppSettings:Issuer"),
                audience: configuration.GetValue<string>("AppSettings:Audience"),
                claims: claims,
                expires: DateTime.UtcNow.AddDays(1),
                signingCredentials: creds
            );
            return new JwtSecurityTokenHandler().WriteToken(tokenDescriptor);
        }
    }
}