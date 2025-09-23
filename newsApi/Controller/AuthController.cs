using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using newsApi.Entities;
using newsApi.Models;
using newsApi.Services;

namespace newsApi.Controller
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController(IAuthService authService) : ControllerBase
    {
        [HttpPost("admin/register")]
        public async Task<ActionResult<Admin>> RegisterAdmin(AdminDto request)
        {
            var admin = await authService.CreateAdminAsync(request);
            if (admin == null)
            {
                return BadRequest("Admin already exist");
            }
            return Ok(admin);
        }
        [HttpPost("admin/login")]
        public async Task<ActionResult<string>> LoginAdmin(AdminDto request)
        {
            var token = await authService.AdminLoginAsync(request);
            if (token == null)
            {
                return BadRequest("Username or password is wrong");
            }
            return Ok(token);
        }
    }
}
