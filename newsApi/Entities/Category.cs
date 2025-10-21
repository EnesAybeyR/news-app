using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace newsApi.Entities;

public class Category
{
    public int Id { get; set; }

    [Column("category_name")]
    public string CategoryName { get; set; } = string.Empty;
}
