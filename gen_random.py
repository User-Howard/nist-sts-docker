import os
import sys

bits = int(sys.argv[1]) if len(sys.argv) > 1 else 1_000_000
bytes_needed = bits // 8

with open("test_random.bin", "wb") as f:
    f.write(os.urandom(bytes_needed))

print(f"Generated {bytes_needed} bytes ({bits} bits) -> test_random.bin")
