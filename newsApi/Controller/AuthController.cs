using System.Drawing;
using System.Security.Claims;
using System.Transactions;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Query.Internal;
using newsApi.Entities;
using newsApi.Models;
using newsApi.Models.Tokens;
using newsApi.Services;

namespace newsApi.Controller
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController(IAuthService authService) : ControllerBase
    {
        [HttpPost("admin/register")]
        public async Task<ActionResult> RegisterAdmin(AdminDto request)
        {
            var admin = await authService.CreateAdminAsync(request);
            if (admin == null)
            {
                return BadRequest("Admin already exist");
            }
            return Ok();
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

        [HttpPost("user/register")]
        public async Task<ActionResult> RegisterUser(UserDto request)
        {
            var user = await authService.CreateUserAsync(request);
            if (user == false)
            {
                return BadRequest("User already exist");
            }
            else
            {
                return Ok("User Created");
            }
        }
        [HttpPost("user/nfa")]
        public async Task<ActionResult<bool>> IsNfa(UserDto request)
        {
            var isNfa = await authService.IsNfaActive(request.UserName);
            return Ok(isNfa);
        }

        // [HttpPost("user/nfaId")]
        // [Authorize(Roles ="user")]
        // public async Task<ActionResult<bool>> IsNfaId()
        // {
        //     var username = User.FindFirst(ClaimTypes.Name)?.Value;
        //     var isNfa = await authService.IsNfaActive(username);
        //     return Ok(isNfa);
        // }

        [HttpPost("user/login/nfa")]
        public async Task<ActionResult<TokenResponseDto>> LoginWithNfaUser(UserNfaDto req)
        {
            var verify = await authService.VerifyLoginCodeAsync(req.UserName,req.Code);
            if (verify == true)
            {
                var user = new UserDto
                {
                    UserName = req.UserName,
                    Password = req.Password
                };
                var token = await authService.UserLoginAsync(user);
                if (token == null)
                {
                    return BadRequest("Username or password is wrong");
                }
                return Ok(token);
            }
            return BadRequest("Token expired or wrong");
        }

        [HttpPost("user/login")]
        public async Task<ActionResult<TokenResponseDto>> LoginUser(UserDto request)
        {
            var token = await authService.UserLoginAsync(request);
            if (token == null)
            {
                return BadRequest("Username or password is wrong");
            }
            return Ok(token);
        }
        [HttpPut("user/mail/update")]
        [Authorize(Roles = "user")]
        public async Task<ActionResult> EmailUpdate(UpdateEmailDto req)
        {
            var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            var response = await authService.UpdateUserMail(req.mail, Guid.Parse(userId), req.password);
            if (response == null)
            {
                return BadRequest();
            }
            if (response == false)
            {
                return BadRequest("E mail already taken");
            }
            return Ok();
        }

        [HttpGet("user/mail")]
        [Authorize(Roles = "user")]
        public async Task<ActionResult<bool>> IsMailActive()
        {
            var username = User.FindFirst(ClaimTypes.Name)?.Value;
            var response = await authService.IsMailActive(username);
            if(username == null)
            {
                return BadRequest(false);
            }
            if (response == false)
            {
                return Ok(false);
            }
            return Ok(true);
        }
        
        
        [HttpPost("user/refresh-token")]
        public async Task<ActionResult<TokenResponseDto>> RefreshToken(RefreshTokenRequestDto request)
        {
            var result = await authService.RefreshTokensAsync(request);
            if (result is null || result.AccessToken == null || result.RefreshToken == null)
            {
                return Unauthorized("Invalid refresh token");
            }
            return Ok(result);
        }
    }
}
