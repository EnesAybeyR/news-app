using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using newsApi.Entities;
using newsApi.Models;
using newsApi.Services.NewsService;

namespace newsApi.Controller
{
    [Route("api/[controller]")]
    [ApiController]
    public class NewsController(INewsService newsService) : ControllerBase
    {
        [HttpPost]
        [Authorize(Roles = "Editor,Admin")]
        public async Task<ActionResult<News>> CreateNews(NewsDto request, int CategoryId)
        {
            var adminId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (adminId == null)
            {
                return BadRequest("You should sign in as a editor");
            }
            var result = await newsService.CreateNew(request, CategoryId, Guid.Parse(adminId));
            if (result == null)
            {
                return BadRequest("Invalid inputs");
            }
            return Ok(result);
        }
    }
}
