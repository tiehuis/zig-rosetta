const std = @import("std");

fn subleq(in: std.os.File, out: std.os.File, m: []i8) !void {
    var ip: isize = 0;
    var buf: [1]u8 = undefined;

    while (ip >= 0) {
        const ipi = @intCast(usize, ip);
        const a = m[ipi];
        const b = m[ipi + 1];
        const c = m[ipi + 2];

        const ai = @bitCast(u8, a);
        const bi = @bitCast(u8, b);

        if (a == -1) {
            _ = try in.read(buf[0..]);
            m[bi] = @bitCast(i8, buf[0]);
        } else if (b == -1) {
            buf[0] = @bitCast(u8, m[ai]);
            try in.write(buf[0..]);
        } else {
            m[bi] -= m[ai];
            if (m[bi] < 1) {
                ip = c;
                continue;
            }
        }

        ip += 3;
    }
}

pub fn main() !void {
    var m = []i8{
        15, 17, -1, 17, -1, -1, 16, 1, -1, 16, 3, -1, 15, 15, 0, 0, -1, 72,
        101, 108, 108, 111, 44, 32, 119, 111, 114, 108, 100, 33, 10, 0,
    };

    var stdout = try std.io.getStdOut();
    var stdin = try std.io.getStdIn();
    try subleq(stdin, stdout, m[0..]);
}
