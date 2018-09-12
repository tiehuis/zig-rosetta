const std = @import("std");

fn diff(b1: f64, b2: f64) f64 {
    var r = @rem(b2 - b1, 360.0);
    if (r < -180.0) {
        r += 360.0;
    }
    if (r >= 180.0) {
        r -= 360.0;
    }
    return r;
}

pub fn main() void {
    std.debug.warn("Input in -180 to +180 range\n");
    std.debug.warn("{.}\n", diff(20.0, 45.0));
    std.debug.warn("{.}\n", diff(-45.0, 45.0));
    std.debug.warn("{.}\n", diff(-85.0, 90.0));
    std.debug.warn("{.}\n", diff(-95.0, 90.0));
    std.debug.warn("{.}\n", diff(-45.0, 125.0));
    std.debug.warn("{.}\n", diff(-45.0, 145.0));
    std.debug.warn("{.}\n", diff(-45.0, 125.0));
    std.debug.warn("{.}\n", diff(-45.0, 145.0));
    std.debug.warn("{.}\n", diff(29.4803, -88.6381));
    std.debug.warn("{.}\n", diff(-78.3251, -159.036));

    std.debug.warn("Input in wider range\n");
    std.debug.warn("{.}\n", diff(-70099.74233810938, 29840.67437876723));
    std.debug.warn("{.}\n", diff(-165313.6666297357, 33693.9894517456));
    std.debug.warn("{.}\n", diff(1174.8380510598456, -154146.66490124757));
    std.debug.warn("{.}\n", diff(60175.77306795546, 42213.07192354373));
}
