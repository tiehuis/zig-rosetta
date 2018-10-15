const std = @import("std");

const Card = struct.{
    const Suit = enum.{
        Spade,
        Club,
        Diamond,
        Heart,
    };

    suit: Suit,
    value: u4,

    pub fn format(
        self: Card,
        comptime fmt: []const u8,
        context: var,
        comptime Errors: type,
        output: fn (@typeOf(context), []const u8) Errors!void,
    ) Errors!void {
        const suits = [][]const u8.{
            "♠", "♣", "♦", "♥",
        };

        const values = [][]const u8.{
            "A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K",
        };

        return std.fmt.format(context, Errors, output, "{}{}", values[self.value], suits[@enumToInt(self.suit)]);
    }

    pub fn lessThan(a: Card, b: Card) bool {
        if (@enumToInt(a.suit) == @enumToInt(b.suit)) {
            return a.value <= b.value;
        } else {
            return @enumToInt(a.suit) < @enumToInt(b.suit);
        }
    }
};

const Deck = struct.{
    // Double-sized since we treat the deck as a circular buffer to allow cards to be placed
    // back into the deck.
    cards: [104]Card,
    start: usize,
    count: usize,

    pub fn new() Deck {
        var cards: [104]Card = undefined;

        var s: usize = 0;
        while (s < 4) : (s += 1) {
            var v: u4 = 0;
            while (v < 13) : (v += 1) {
                const card = Card.{
                    .suit = @intToEnum(Card.Suit, @intCast(@TagType(Card.Suit), s)),
                    .value = v,
                };

                cards[usize(s) * 13 + v] = card;
                cards[52 + usize(s) * 13 + v] = card;
            }
        }

        return Deck.{ .cards = cards, .start = 0, .count = 52 };
    }

    pub fn show(deck: *const Deck) void {
        for (deck.toSliceConst()) |card| {
            std.debug.warn("{} ", card);
        }
        std.debug.warn("\n");
    }

    pub fn toSliceConst(deck: *const Deck) []const Card {
        return deck.cards[deck.start .. deck.start + deck.count];
    }

    pub fn deal(deck: *Deck) ?Card {
        if (deck.count == 0) return null;

        const card = deck.cards[deck.start];
        deck.start = (deck.start + 1) % 52;
        deck.count -= 1;
        return card;
    }

    pub fn shuffle(deck: *Deck, random: *std.rand.Random) void {
        random.shuffle(Card, deck.cards[deck.start .. deck.start + deck.count]);

        var i: usize = 52;
        while (i < deck.start + deck.count) : (i += 1) {
            deck.cards[i - 52] = deck.cards[i];
        }
    }
};

pub fn main() void {
    var deck = Deck.new();

    std.debug.warn("New deck:\n");
    deck.show();

    var prng = std.rand.DefaultPrng.init(0);
    deck.shuffle(&prng.random);

    std.debug.warn("\nShuffled deck:\n");
    deck.show();

    std.debug.warn("\nDeal 4 hands\n");
    var i: usize = 0;
    while (i < 4) : (i += 1) {
        var j: usize = 0;
        while (j < 5) : (j += 1) {
            std.debug.warn("{} ", deck.deal().?);
        }
        std.debug.warn("\n");
    }

    std.debug.warn("\nLeft in deck {} cards:\n", deck.count);
    deck.show();
}
