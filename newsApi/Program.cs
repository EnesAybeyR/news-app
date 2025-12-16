    using System.Text;
    using Microsoft.AspNetCore.Authentication.JwtBearer;
    using Microsoft.EntityFrameworkCore;
    using Microsoft.IdentityModel.Tokens;
    using newsApi.Data;
    using newsApi.Services;
    using newsApi.Services.NewsService;
    using Scalar.AspNetCore;
    using FluentEmail.Smtp;
    using System.Net;
    using System.Net.Mail;
    using DotNetEnv;


    var builder = WebApplication.CreateBuilder(args);

    Env.Load();
    var token = Environment.GetEnvironmentVariable("TOKEN");
    builder.Services.AddOpenApi();
    builder.Services.AddDbContext<AppDbContext>(options => options.UseSqlite("Data Source=news.db"));
    builder.Services.AddControllers();
    builder.Services.AddScoped<IAuthService, AuthService>();
    builder.Services.AddScoped<INewsService, NewsService>();
    builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme).AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new Microsoft.IdentityModel.Tokens.TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidIssuer = Environment.GetEnvironmentVariable("ISSUER"),
            ValidateAudience = true,
            ValidAudience = Environment.GetEnvironmentVariable("AUDIENCE"),
            ValidateLifetime = true,
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(token)),
            ValidateIssuerSigningKey = true,
        };
    });

    builder.Services.AddFluentEmail(Environment.GetEnvironmentVariable("EMAILNAME")).AddSmtpSender(new SmtpClient("smtp.gmail.com")
    {
        Port = 587,
        Credentials = new NetworkCredential(Environment.GetEnvironmentVariable("EMAILNAME"),Environment.GetEnvironmentVariable("EMAILCODE")),
        EnableSsl = true,
    });



    var app = builder.Build();



    // Configure the HTTP request pipeline.
    if (app.Environment.IsDevelopment())
    {
        app.MapOpenApi();
        app.MapScalarApiReference();
    }

    app.UseHttpsRedirection();

    app.UseAuthentication();
    app.UseAuthorization();
    app.MapControllers();

    app.Run();

