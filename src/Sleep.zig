const std = @import("std");
const time = std.os.time;

pub fn main() void {
    std.os.time.sleep(1 * time.second + 100 * time.nanosecond);
}
