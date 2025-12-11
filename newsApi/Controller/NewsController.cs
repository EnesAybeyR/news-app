using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using newsApi.Entities;
using newsApi.Models;
using newsApi.Services.NewsService;

namespace newsApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NewsController(INewsService newsService) : ControllerBase
    {
        [HttpPost]
        [Authorize(Roles = "Editor,Admin")]
        public async Task<ActionResult<News>> CreateNews([FromBody]NewsDto request)
        {
            var adminId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (adminId == null)
            {
                return BadRequest("You should sign in as a editor");
            }
            var result = await newsService.CreateNew(request, Guid.Parse(adminId));
            if (result == null)
            {
                return BadRequest("Invalid inputs");
            }
            return Ok(result);
        }
        [HttpDelete("delete/{id}")]
        [Authorize(Roles = "Admin,Editor")]
        public async Task<ActionResult> DeleteNews(Guid id)
        {
            var result = await newsService.DeleteNew(id);
            if (result == false)
            {
                return NotFound("New not found");
            }
            return Ok("New deleted");
        }

        [HttpGet("getallnews")]
        public async Task<ActionResult<List<News>>> GetAllNews([FromQuery]int page = 1,[FromQuery]int pageSize = 10)
        {
            var result = await newsService.GetNewsAsync(page, pageSize);
            return Ok(result);
        }
        [HttpGet("getNewsByCategory/{id}")]
        public async Task<ActionResult<List<News>>> GetNewsByCategory(int id)
        {
            var result = await newsService.GetNewsByCategoryAsync(id);
            return Ok(result);
        }

        [HttpGet("search/{newName}")]
        public async Task<ActionResult<List<News>>> GetNewsByName(String newName)
        {
            var result = await newsService.GetNewsByNameAsync(newName);
            if (result == null)
            {
                return Ok();
            }
            return Ok(result);
        } 

        [HttpGet("getName/{id}")]
        public async Task<ActionResult<string>> GetName(string id)
        {
            var result = await newsService.GetEditorNameAsync(Guid.Parse(id));
            if (result == null)
            {
                return Ok("");
            }
            return Ok(result);
        }
        [HttpPost("comment/{id}")]
        [Authorize(Roles = "user")]
        public async Task<ActionResult> CreateNewComment(string id, NewCommentDto request)
        {
            var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (userId == null)
            {
                return BadRequest("You should sign in");
            }
            var result = await newsService.CreateNewCommentAsync(request, Guid.Parse(userId), Guid.Parse(id));
            if (result == null)
            {
                return BadRequest("Invalid inputs");
            }
            return Ok();
        }
        [HttpGet("comment/{id}")]
        public async Task<ActionResult<List<NewsComments>>> GetComments(string id)
        {
            var result = await newsService.GetAllCommentsAsync(Guid.Parse(id));
            return Ok(result);
        }

        [Authorize(Roles = "user")]
        [HttpPost("bookmarks/add/{id}")]
        public async Task<ActionResult> AddBookmarks(string id)
        {
            var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (userId == null)
            {
                return BadRequest("You should sign in");
            }
            var userBookmark = new UserBookmarks();
            userBookmark.UserId = Guid.Parse(userId);
            userBookmark.NewId = Guid.Parse(id);
            var result = await newsService.CreateBookMarkAsync(userBookmark);
            return Ok();
        }
        [HttpDelete("bookmarks/delete/{id}")]
        [Authorize(Roles = "user")]
        public async Task<ActionResult> DeleteBookmark(string id)
        {
            var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (userId == null)
            {
                return BadRequest("You should sign in");
            }

            var result = await newsService.DeleteBookmarkAsync(Guid.Parse(id));
            if (result == false)
            {
                return NotFound("Bookmark not found");
            }
            return Ok("Bookmark deleted");
        }
        [HttpGet("bookmarks")]
        [Authorize(Roles = "user")]
        public async Task<ActionResult<List<BookmarkReturnDto>>> GetUserBookmarks()
        {
            var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (userId == null)
            {
                return BadRequest("You should sign in");
            }
            var result = await newsService.GetUserBookmarksAsync(Guid.Parse(userId));
            return Ok(result);
        }
        
    }
}
