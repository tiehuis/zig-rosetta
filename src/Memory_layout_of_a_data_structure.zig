const std = @import("std");

const RS232 = packed struct.{
    carrier_detect: u1,
    received_data: u1,
    transmitted_data: u1,
    data_terminal_ready: u1,
    signal_ground: u1,
    data_set_ready: u1,
    request_to_send: u1,
    clear_to_send: u1,
    ring_indicator: u1,
};

pub fn main() void {
    std.debug.warn("{}\n", usize(@sizeOf(RS232)));
}
