const std = @import("std");

pub fn main() void {
    const empty = "";

    if (empty.len == 0) {
        std.debug.warn("string is empty\n");
    }

    if (empty.len != 0) {
        std.debug.warn("string is not empty\n");
    }
}
