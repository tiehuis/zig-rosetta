const std = @import("std");

fn radians(x: f64) f64 {
    return x * (std.math.pi / 180.0);
}

fn degrees(x: f64) f64 {
    return x / (std.math.pi / 180.0);
}

pub fn main() void {
    const lat: f64 = -4.95;
    const lng: f64 = -150.5;
    const lme: f64 = -150;

    const slat = std.math.sin(radians(lat));
    std.debug.warn(
        \\latitude:         {}
        \\longitude:        {}
        \\legal meridian:   {}
        \\sine of latitude: {}
        \\diff longitude:   {}
        \\
        \\
    , lat, lng, lme, slat, lng - lme);

    std.debug.warn("Hour, sun hour angle, dial hour line angle from 6am to 6pm\n");

    var h: isize = -6;
    while (h < 7) : (h += 1) {
        const hra = 15 * @intToFloat(f64, h) - (lng - lme);
        const hla = degrees(std.math.atan(slat * std.math.tan(radians(hra))));

        // TODO: Better print formatting functions would help here.
        std.debug.warn("HR= {}; HRA= {.3}; HLA= {.3}\n", h, hra, hla);
    }
}
