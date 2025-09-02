#!/usr/bin/env python3
import subprocess
import sys

if len(sys.argv) != 3:
    print("USAGE: copy.py <source/path> <dest/path>")
    sys.exit(1)

subprocess.run(["rsync", "-avhzP", sys.argv[1], sys.argv[2]])
