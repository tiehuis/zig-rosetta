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

        // TODO: This interface is way too ugly. Take only nanoseconds and expose some constants so
        // the call can become `time.sleep(ms * time.milliseconds)`;
        time.sleep(
            ms / time.ms_per_s,
            @floatToInt(usize, (time.ns_per_s * (@intToFloat(f64, ms) / time.ms_per_s))) % time.ns_per_s,
        );
    }
}

pub fn main() void {
    metronome(100, 4);
}
