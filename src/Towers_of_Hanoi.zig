const std = @import("std");

fn move(n: usize, from: u8, to: u8, via: u8) void {
    if (n > 0) {
        move(n - 1, from, via, to);
        std.debug.warn("Move disk from {c} to {c}\n", from, to);
        move(n - 1, via, to, from);
    }
}

pub fn main() void {
    move(4, 'L', 'M', 'R');
}
