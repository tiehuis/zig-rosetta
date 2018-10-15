const std = @import("std");
const time = std.os.time;

fn metronome(bpm: usize, bpb: usize) void {
    const ms = 60000 / bpm;
    var c: usize = 0;

    while (true) : (c += 1) {
        if (c % bpb == 0) {
            std.debug.warn("\nTick");
        } else {
            std.debug.warn(" tick");
        }

        time.sleep(
            ms +
            @floatToInt(usize, (time.nanosecond * (@intToFloat(f64, ms) / time.millisecond))) % time.nanosecond,
        );
    }
}

pub fn main() void {
    metronome(100, 4);
}
