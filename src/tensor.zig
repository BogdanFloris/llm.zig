const std = @import("std");
const testing = std.testing;
const Allocator = std.mem.Allocator;
const Configuration = @import("./configuration.zig").Configuration;

pub fn Tensor(comptime T: type, comptime N: usize) type {
    return struct {
        items: []T,
        shape: [N]usize,
        allocator: Allocator,
        options: Configuration,

        const Self = @This();

        pub fn init(
            shape: [N]usize,
            allocator: Allocator,
            options: Configuration,
        ) !Self {
            var size: usize = 1;
            inline for (shape) |s| {
                size *= s;
            }

            const items = try allocator.alloc(T, size);
            @memset(items, 0);

            return Self{
                .items = items,
                .shape = shape,
                .allocator = allocator,
                .options = options,
            };
        }

        pub fn deinit(self: *Self) void {
            self.allocator.free(self.items);
        }
    };
}

test "Tensor" {
    var t = try Tensor(f32, 3).init(.{ 4, 4, 4 }, testing.allocator, .{});
    defer t.deinit();

    // Check that the shape is correct
    try testing.expectEqualSlices(usize, &t.shape, &.{ 4, 4, 4 });
    // Check that the items are initialized to 0
    for (t.items) |item| {
        try testing.expectEqual(item, 0);
    }
}
