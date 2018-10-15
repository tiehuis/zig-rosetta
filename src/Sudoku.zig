const std = @import("std");

const sudoku = struct.{
    fn isValid(b: []const u8, i: usize, v: u8) bool {
        var j: usize = undefined;

        j = i % 9;
        while (j < 81) : (j += 9) {
            if (b[j] == v) return false;
        }

        j = i - (i % 9);
        while (j < i + 9 - (i % 9)) : (j += 1) {
            if (b[j] == v) return false;
        }

        j = i - (i % 3) - 9 * ((i / 9) % 3);
        var k: usize = 0;
        while (k < 9) : ({
            k += 1;
            j += if (k % 3 != 0) usize(1) else 7;
        }) {
            if (b[j] == v) return false;
        }

        return true;
    }

    fn backtrack(b: []u8, i: usize) bool {
        var v: u8 = 9;
        while (v > 0) : (v -= 1) {
            if (!isValid(b, i, v))
                continue;

            b[i] = v;

            if (backtrack(b, i + (std.mem.indexOfScalar(u8, b[i..], 0) orelse return true)))
                return true;
        }

        b[i] = 0;
        return false;
    }

    pub fn print(b: []u8) void {
        var y: usize = 0;
        while (y < 9) : (y += 1) {
            var x: usize = 0;
            while (x < 9) : (x += 1) {
                std.debug.warn("{} ", b[9 * y + x]);
            }
            std.debug.warn("\n");
        }
    }

    pub fn solve(b: []u8) bool {
        return backtrack(b, std.mem.indexOfScalar(u8, b, 0) orelse return true);
    }
};

pub fn main() void {
    var problem = []u8.{
        8, 5, 0, 0, 0, 2, 4, 0, 0,
        7, 2, 0, 0, 0, 0, 0, 0, 9,
        0, 0, 4, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 1, 0, 7, 0, 0, 2,
        3, 0, 5, 0, 0, 0, 9, 0, 0,
        0, 4, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 8, 0, 0, 7, 0,
        0, 1, 7, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 3, 6, 0, 4, 0,
    };

    if (sudoku.solve(problem[0..])) {
        sudoku.print(problem[0..]);
    } else {
        std.debug.warn("unsolvable puzzle\n");
    }
}
