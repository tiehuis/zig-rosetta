const std = @import("std");

pub fn main() void {
    // 1 second + 100 nanoseconds
    std.os.time.sleep(1 * std.os.time.second + 100 * std.os.time.nanosecond);
}
