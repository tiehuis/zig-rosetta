const std = @import("std");

fn jaroDistance(allocator: *std.mem.Allocator, a: []const u8, b: []const u8) !f64 {
    if (a.len == 0) {
        return if (b.len == 0) f64(1.0) else 0.0;
    }

    const match_distance = std.math.max(a.len, b.len) / 2 - 1;

    const am = try allocator.alloc(bool, a.len);
    std.mem.set(bool, am, false);
    defer allocator.free(am);

    const bm = try allocator.alloc(bool, b.len);
    std.mem.set(bool, bm, false);
    defer allocator.free(bm);

    var matches: f64 = 0.0;
    for (a) |_, i| {
        const start = if (match_distance > i) 0 else i - match_distance;
        const end = std.math.min(i + match_distance + 1, b.len);

        var k: usize = start;
        while (k < end) : (k += 1) {
            if (bm[k]) {
                continue;
            }
            if (a[i] != b[k]) {
                continue;
            }

            am[i] = true;
            bm[k] = true;
            matches += 1;
            break;
        }
    }

    if (matches == 0) {
        return 0.0;
    }

    var transpositions: f64 = 0.0;
    var k: usize = 0;
    for (a) |_, i| {
        if (!am[i]) {
            continue;
        }
        while (!bm[k]) {
            k += 1;
        }

        if (a[i] != b[k]) {
            transpositions += 1;
        }

        k += 1;
    }

    return ((matches / @intToFloat(f64, a.len)) +
        (matches / @intToFloat(f64, b.len)) +
        ((matches - (transpositions / 2)) / matches)) / 3;
}

pub fn main() !void {
    var allocator = std.debug.global_allocator;
    std.debug.warn("{.6}\n", try jaroDistance(allocator, "MARTHA", "MARHTA"));
    std.debug.warn("{.6}\n", try jaroDistance(allocator, "DIXON", "DICKSONX"));
    std.debug.warn("{.6}\n", try jaroDistance(allocator, "JELLYFISH", "SMELLYFISH"));
}
