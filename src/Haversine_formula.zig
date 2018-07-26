const std = @import("std");
const math = std.math;

fn haversine(dth1: f64, dph1: f64, dth2: f64, dph2: f64) f64 {
    const earth_radius_km = 6371;
    const to_radians = f64(math.pi) / 180;

    const ph1d = dph1 - dph2;
    const ph1 = ph1d * to_radians;
    const th1 = dth1 * to_radians;
    const th2 = dth2 * to_radians;

    const dx = math.cos(ph1) * math.cos(th1) - math.cos(th2);
    const dy = math.sin(ph1) * math.cos(th1);
    const dz = math.sin(th1) - math.sin(th2);

    return math.asin(math.sqrt(dx * dx + dy * dy + dz * dz) / 2) * 2 * earth_radius_km;
}

pub fn main() void {
    std.debug.warn("Haversine distance: {.3} km\n", haversine(36.12, -86.67, 33.94, -118.4));
}
