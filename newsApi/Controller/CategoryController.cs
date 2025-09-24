using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using newsApi.Data;
using newsApi.Entities;
using newsApi.Models;

namespace newsApi.Controller
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategoryController : ControllerBase
    {
        private readonly AppDbContext _appDbContext;
        public CategoryController(AppDbContext appDbContext)
        {
            _appDbContext = appDbContext;
        }
        [HttpGet]
        public async Task<ActionResult<List<Category>>> GetAllCategories()
        {
            var categories = await _appDbContext.Categories.ToListAsync();
            return Ok(categories);
        }

        [HttpPost]
        [Authorize(Roles = "Admin")]
        public async Task<ActionResult<Category>> AddCategory(CategoryDto request)
        {
            if (request is null || request.CategoryName == null)
            {
                return BadRequest("Category is empty");
            }
            if (await _appDbContext.Categories.AnyAsync(a => a.CategoryName == request.CategoryName))
            {
                return BadRequest("Category already exists");
            }
            var category = new Category();
            category.CategoryName = request.CategoryName;
            _appDbContext.Categories.Add(category);
            await _appDbContext.SaveChangesAsync();
            return Ok(category);
        }
    }
}
