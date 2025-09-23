using System;

namespace newsApi.Entities;

public class News
{
    public Guid Id { get; set; }
    public string Headline { get; set; } = string.Empty;
    public DateTime CreateDate { get; set; } = DateTime.Now;

    public string CountryName { get; set; } = string.Empty;

    public int EntryCount { get; set; } = 0;

    public Guid? EditorId { get; set; }
    public int? CategoryId { get; set; }


}
