const std = @import("std");

fn sparkline(n: []const f64) void {
    const lines = [][]const u8{
        "▁",
        "▂",
        "▃",
        "▄",
        "▅",
        "▆",
        "▇",
        "█",
    };

    if (n.len == 0) return;

    var max: f64 = -1000;
    var min: f64 = 1000;
    for (n) |e| {
        if (e > max) max = e;
        if (e < min) min = e;
    }

    const spread = 8 / (max - min);
    for (n) |e| {
        var i = @floatToInt(usize, spread * (e - min));
        if (i >= lines.len) i = lines.len - 1;
        std.debug.warn("{}", lines[i]);
    }
    std.debug.warn("\n");
}

pub fn main() void {
    const n1 = []f64{ 1, 2, 3, 4, 5, 6, 7, 8, 7, 6, 5, 4, 3, 2, 1 };
    const n2 = []f64{ 1.5, 0.5, 3.5, 2.5, 5.5, 4.5, 7.5, 6.5 };

    sparkline(n1);
    sparkline(n2);
}
