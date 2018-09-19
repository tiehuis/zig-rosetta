const c = @cImport({
    @cInclude("readline/readline.h");
    @cInclude("readline/history.h");
    @cInclude("string.h");
});

pub fn main() u8 {
    c.using_history();

    while (true) {
        const s = c.readline(c"> ");

        if (s == null or c.strcmp(s, c"quit") == 0) {
            _ = c.puts(c"bye.");
            return 0;
        }

        if (c.strcmp(s, c"help") == 0) {
            _ = c.puts(c"commands: ls, cat, quit");
        } else if (c.strcmp(s, c"ls") == 0 or c.strcmp(s, c"cat") == 0) {
            _ = c.printf(c"command `%s' not implemented yet.\n", s);
            c.add_history(s);
        } else {
            _ = c.puts(c"Yes...?");
        }
    }
}
