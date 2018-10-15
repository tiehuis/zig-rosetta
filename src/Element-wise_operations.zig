const std = @import("std");

// Assumes input and output slices are all equal length.
fn Matrix(comptime T: type, comptime M: usize, comptime N: usize) type {
    return struct.{
        pub const ops = struct.{
            fn add(a: T, b: T) T {
                return a + b;
            }

            fn sub(a: T, b: T) T {
                return a - b;
            }

            fn mul(a: T, b: T) T {
                return a * b;
            }

            fn div(a: T, b: T) T {
                return a / b;
            }
        };

        fn new() [N][M]T {
            var s: [N][M]T = undefined;
            return s;
        }

        fn apply(r: *[N][M]T, a: []const []const T, b: []const []const T, func: fn (a: T, b: T) T) void {
            for (a) |e, i| {
                for (e) |_, j| {
                    r[i][j] = func(a[i][j], b[i][j]);
                }
            }
        }

        // In standard code it would be better to implement multi-dimensional arrays on
        // linear memory, handle the indexing in the struct and avoid allowing slices as
        // arguments.
        fn show(a: []const []const T) void {
            for (a) |e| {
                std.debug.warn("[ ");
                for (e) |v| {
                    std.debug.warn("{} ", v);
                }
                std.debug.warn("]\n");
            }
        }

        fn showF(a: [N][M]T) void {
            for (a) |e| {
                std.debug.warn("[ ");
                for (e) |v| {
                    std.debug.warn("{} ", v);
                }
                std.debug.warn("]\n");
            }
        }
    };
}

pub fn main() void {
    const matrix = Matrix(f32, 3, 2);

    const m1 = [][]const f32.{
        []const f32.{ 3, 1, 4 },
        []const f32.{ 1, 5, 9 },
    };

    const m2 = [][]const f32.{
        []const f32.{ 2, 7, 1 },
        []const f32.{ 8, 2, 8 },
    };

    var r = matrix.new();

    std.debug.warn("m1:\n");
    matrix.show(m1);

    std.debug.warn("m2:\n");
    matrix.show(m2);

    matrix.apply(&r, m1, m2, matrix.ops.add);
    std.debug.warn("\nm1 + m2:\n");
    matrix.showF(r);

    matrix.apply(&r, m1, m2, matrix.ops.sub);
    std.debug.warn("m1 - m2:\n");
    matrix.showF(r);

    matrix.apply(&r, m1, m2, matrix.ops.mul);
    std.debug.warn("m1 * m2:\n");
    matrix.showF(r);

    matrix.apply(&r, m1, m2, matrix.ops.div);
    std.debug.warn("m1 / m2:\n");
    matrix.showF(r);
}
