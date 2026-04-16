#!/usr/bin/env python3
"""Nix darwin wrapper — build and switch to a nix-darwin profile."""

import argparse
import glob
import os
import re
import signal
import subprocess
import sys
from pathlib import Path

DOTFILES = Path.home() / ".dotfiles"


def run(cmd: list[str], **kwargs) -> subprocess.CompletedProcess:
    return subprocess.run(cmd, **kwargs)


def git(*args: str, **kwargs) -> subprocess.CompletedProcess:
    return run(["git", "-C", str(DOTFILES), *args], **kwargs)


def setup() -> None:
    git("update-index", "--no-skip-worktree", "override.nix")
    git("add", "-A")
    deleted = git(
        "ls-files",
        "--deleted",
        capture_output=True,
        text=True,
    ).stdout.split()
    if deleted:
        git("rm", "--", *deleted)
    git(
        "commit",
        "--no-verify",
        "--no-gpg-sign",
        "-m",
        "--wip-- [skip ci]",
        capture_output=True,
    )


def cleanup() -> None:
    log = git("log", "-n", "1", "--format=%s", capture_output=True, text=True).stdout
    if "--wip--" in log:
        git("reset", "HEAD~1", "--quiet")
    git("update-index", "--skip-worktree", "override.nix")


def show_diff(profile: str) -> None:
    def version_key(path: str) -> int:
        m = re.search(r"system-(\d+)-link$", path)
        return int(m.group(1)) if m else 0

    print(f"\033[1;32m\n===== Applied profile: {profile} =====\033[0m")
    profiles = sorted(
        glob.glob("/nix/var/nix/profiles/system-*-link"), key=version_key
    )[-2:]
    if len(profiles) == 2:
        run(["nvd", "diff", *profiles])


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "profile",
        help="Configuration profile (e.g. mooping, work)",
    )
    parser.add_argument(
        "--update",
        action="store_true",
        help="Run nix flake update before rebuilding",
    )
    args = parser.parse_args()

    signal.signal(signal.SIGTERM, lambda *_: sys.exit(128 + signal.SIGTERM))

    orig_dir = Path.cwd()
    os.chdir(DOTFILES)
    setup()

    try:
        if args.update:
            print("Updating flake...")
            run(["nix", "flake", "update"], check=True)

        result = run(
            [
                "sudo",
                "darwin-rebuild",
                "switch",
                "--flake",
                f"{DOTFILES}#{args.profile}",
            ]
        )

        if result.returncode == 0:
            show_diff(args.profile)

        return result.returncode

    finally:
        cleanup()
        os.chdir(orig_dir)


if __name__ == "__main__":
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        sys.exit(130)
