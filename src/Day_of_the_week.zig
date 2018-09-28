const std = @import("std");

const Day = enum {
    Sunday,
    Monday,
    Tuesday,
    Wednesday,
    Thursday,
    Friday,
    Saturday,
};

fn dayOfWeek(year: usize, month: usize, date: usize) Day {
    std.debug.assert(1 <= month and month <= 12);

    const a = (14 - month) / 12;
    const m = month + 12 * a - 2;
    const y = year - a;

    return @intToEnum(Day, @intCast(u3, (date + (13 * m - 1) / 5 + y + y / 4 - y / 100 + y / 400) % 7));
}

pub fn main() void {
    var y: usize = 2008;
    while (y <= 2121) : (y += 1) {
        switch (dayOfWeek(y, 12, 25)) {
            Day.Sunday => {
                std.debug.warn("{}\n", y);
            },
            else => {},
        }
    }
}
