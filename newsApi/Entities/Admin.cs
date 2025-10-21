using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace newsApi.Entities;

public class Admin
{
    public Guid Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Surname { get; set; } = string.Empty;

    [MaxLength(25)]
    [Column("user_name")]
    public string UserName { get; set; } = string.Empty;
    [Column("hashed_password")]
    public string HashedPassword { get; set; } = string.Empty;
    public string Role { get; set; } = string.Empty;

}
