verify:
	@find ./src -type f -name '*.zig' -print -exec \
		zig build-exe --output /dev/null --cache-dir /tmp/zig-cache {} \;
