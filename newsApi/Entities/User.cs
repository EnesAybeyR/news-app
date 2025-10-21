using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace newsApi.Entities;

public class User
{
    public Guid Id { get; set; }

    [MaxLength(25)]
    [Column("user_name")]
    [Required]
    public string UserName { get; set; } = string.Empty;
    [Column("hashed_password")]
    public string HashedPassword { get; set; } = string.Empty;
    public string Role { get; set; } = "user";

    [EmailAddress]
    public string? Email { get; set; } = string.Empty;
    [Phone]
    public string? PhoneNumber { get; set; } = string.Empty;

    public string? RefreshToken { get; set; }

    public DateTime? RefreshTokenExpiryTime { get; set; }

}
