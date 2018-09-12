const std = @import("std");

pub fn main() void {
    var depth: usize = 3;
    var dim: usize = 1;

    {
        var i: usize = 0;
        while (i < depth) : ({
            i += 1;
            dim *= 3;
        }) {}
    }

    {
        var i: usize = 0;
        while (i < dim) : (i += 1) {
            var j: usize = 0;
            while (j < dim) : (j += 1) {
                var d = dim / 3;
                while (d != 0) : (d /= 3) {
                    if ((i % (d * 3)) / d == 1 and (j % (d * 3)) / d == 1)
                        break;
                }

                if (d != 0) {
                    std.debug.warn("  ");
                } else {
                    std.debug.warn("##");
                }
            }
            std.debug.warn("\n");
        }
    }
}
