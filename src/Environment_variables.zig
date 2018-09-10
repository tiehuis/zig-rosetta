const std = @import("std");

pub fn main() void {
    var allocator = std.debug.global_allocator;
    std.debug.warn("{}\n", std.os.getEnvVarOwned(allocator, "HOME"));
}
