#!/usr/bin/env python3

import os
import subprocess

class GitDirException(Exception):
    pass

def find_git_folders(git_dirs, root_dir):
    subfolders = [f for f in os.listdir(root_dir) if os.path.isdir(f"{root_dir}/{f}")]

    if ".git" in subfolders:
        git_dirs.append(root_dir)
        print(root_dir)
        return []

    for dirname in subfolders:
        if dirname == ".git":
            raise GitDirException

        find_git_folders(git_dirs, f"{root_dir}/{dirname}")

git_dirs = []
find_git_folders(git_dirs, os.getcwd())

for dir in git_dirs:
    subprocess.run(["git", "-C", dir, "all", "fetch"])

