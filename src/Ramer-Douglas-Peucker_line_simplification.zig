const std = @import("std");

const Point = struct {
    x: f64,
    y: f64,
};

fn ramerDouglasPeucker(out: []Point, line: []const Point, epsilon: f64) []Point {
    std.debug.assert(line.len >= 2);
    std.debug.assert(out.len >= line.len);

    var x: usize = 0;
    var d_max: f64 = -1;

    var p1 = line[0];
    var p2 = line[line.len - 1];
    var x21 = p2.x - p1.x;
    var y21 = p2.y - p1.y;

    for (line[1..]) |p, i| {
        const d = std.math.fabs(y21 * p.x - x21 * p.y + p2.x * p1.y - p2.y * p1.x);
        if (d > d_max) {
            x = i + 1;
            d_max = d;
        }
    }

    if (d_max > epsilon) {
        const o1 = ramerDouglasPeucker(out[0..], line[0 .. x + 1], epsilon);
        const o2 = ramerDouglasPeucker(out[o1.len..], line[x + 1 ..], epsilon);
        return out[0 .. o1.len + o2.len];
    } else {
        out[0] = line[0];
        out[1] = line[line.len - 1];
        return out[0..2];
    }
}

pub fn main() void {
    var line = []Point{
        Point{ .x = 0, .y = 0 },
        Point{ .x = 1, .y = 0.1 },
        Point{ .x = 2, .y = -0.1 },
        Point{ .x = 3, .y = 5 },
        Point{ .x = 4, .y = 6 },
        Point{ .x = 5, .y = 7 },
        Point{ .x = 6, .y = 8.1 },
        Point{ .x = 7, .y = 9 },
        Point{ .x = 8, .y = 9 },
        Point{ .x = 9, .y = 9 },
    };

    var output: [line.len]Point = undefined;
    const reduced = ramerDouglasPeucker(output[0..], line, 1);

    for (reduced) |p| {
        std.debug.warn("({}, {}) ", p.x, p.y);
    }
    std.debug.warn("\n");
}
