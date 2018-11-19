const std = @import("std");

fn hq9p(stream: *std.os.File.OutStream.Stream, program: []const u8) !void {
    var acc: usize = 0;
    for (program) |p| {
        switch (p) {
            'Q' => try stream.print("{}\n", program),
            'H' => try stream.print("Hello, world!\n"),
            '9' => {
                var bottles: usize = 99;
                while (bottles != 0) : (bottles -= 1) {
                    try stream.print(
                        \\{} bottles of beer on the wall
                        \\{} bottles of beer
                        \\Take one down, pass it around
                        \\{} bottles of beer on the wall
                        \\
                        \\
                    , bottles, bottles, bottles - 1);
                }
            },
            else => acc += 1,
        }
    }
}

pub fn main() !void {
    var stdout = try std.io.getStdOut();
    var out_stream = stdout.outStream();
    try hq9p(&out_stream.stream, "HQ+");
}
