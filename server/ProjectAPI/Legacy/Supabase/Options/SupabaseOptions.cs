// Legacy Supabase implementation - kept for reference.
namespace ProjectAPI.Legacy.Supabase.Options;

public sealed class SupabaseOptions
{
    public string Url { get; set; } = default!;
    public string AnonKey { get; set; } = default!;
    public string? ServiceRoleKey { get; set; }
}