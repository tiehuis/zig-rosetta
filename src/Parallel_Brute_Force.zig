const std = @import("std");
const Sha256 = std.crypto.Sha256;

const NeedleHash = struct {
    s: []const u8,
    b: [Sha256.digest_length]u8,

    pub fn new(s: []const u8) NeedleHash {
        var b: [Sha256.digest_length]u8 = undefined;
        std.fmt.hexToBytes(b[0..], s) catch unreachable;

        return NeedleHash{
            .s = s,
            .b = b,
        };
    }
};

const alphabet = "abcdefghijklmnopqrstuvwxyz";

const needles = []NeedleHash{
    NeedleHash.new("1115dd800feaacefdf481f1f9070374a2a81e27880f187396db67958b207cbad"),
    NeedleHash.new("3a7bd3e2360a3d29eea436fcfb7e44c735d117c42d1c1835420b6b9942dd4f1b"),
    NeedleHash.new("74e1bb62f8dabb8125a58852b63bdf6eaef667cb56ac7f7cdba6d7305c50a22f"),
};

const BruteForceContext = struct {
    start: usize,
    end: usize,
};

fn bruteForce(context: BruteForceContext) void {
    for (alphabet[context.start..context.end]) |a| {
        for (alphabet) |b| {
            for (alphabet) |c| {
                for (alphabet) |d| {
                    for (alphabet) |e| {
                        const password = []const u8{ a, b, c, d, e };
                        var computed: [Sha256.digest_length]u8 = undefined;
                        Sha256.hash(password[0..], computed[0..]);

                        inline for (needles) |n| {
                            if (std.mem.eql(u8, computed[0..], n.b[0..])) {
                                std.debug.warn("{} {}\n", password[0..], n.s);
                                break;
                            }
                        }
                    }
                }
            }
        }
    }
}

pub fn main() !void {
    var allocator = std.debug.global_allocator;

    const batch_size = alphabet.len / (try std.os.cpuCount(allocator));

    var threads = std.ArrayList(*std.os.Thread).init(allocator);
    defer threads.deinit();

    var i: usize = 0;
    while (i < alphabet.len) : (i += batch_size) {
        const context = BruteForceContext{
            .start = i,
            .end = i + batch_size,
        };

        try threads.append(try std.os.spawnThread(context, bruteForce));
    }

    for (threads.toSliceConst()) |thread| {
        thread.wait();
    }
}
