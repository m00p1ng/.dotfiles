#!/usr/bin/env python3
"""Nix darwin wrapper — build and switch to the nix-darwin profile in NIX_PROFILE."""

import argparse
import glob
import os
import re
import signal
import subprocess
import sys
from pathlib import Path
from types import FrameType
from typing import NoReturn

DOTFILES = Path.home() / ".dotfiles"


class Args(argparse.Namespace):
    update: bool = False


def run(
    cmd: list[str],
    *,
    capture_output: bool = False,
    check: bool = False,
) -> subprocess.CompletedProcess[str]:
    return subprocess.run(cmd, capture_output=capture_output, check=check, text=True)


def git(*args: str, capture_output: bool = False) -> subprocess.CompletedProcess[str]:
    return run(["git", "-C", str(DOTFILES), *args], capture_output=capture_output)


def setup() -> None:
    _ = git("update-index", "--no-skip-worktree", "override.nix")
    _ = git("add", "-A")
    deleted = git(
        "ls-files",
        "--deleted",
        capture_output=True,
    ).stdout.split()
    if deleted:
        _ = git("rm", "--", *deleted)
    _ = git(
        "commit",
        "--no-verify",
        "--no-gpg-sign",
        "-m",
        "--wip-- [skip ci]",
        capture_output=True,
    )


def cleanup() -> None:
    log = git("log", "-n", "1", "--format=%s", capture_output=True).stdout
    if "--wip--" in log:
        _ = git("reset", "HEAD~1", "--quiet")
    _ = git("update-index", "--skip-worktree", "override.nix")


def show_diff(profile: str) -> None:
    def version_key(path: str) -> int:
        m = re.search(r"system-(\d+)-link$", path)
        return int(m.group(1)) if m else 0

    print(f"\033[1;32m\n===== Applied profile: {profile} =====\033[0m")
    profiles = sorted(
        glob.glob("/nix/var/nix/profiles/system-*-link"), key=version_key
    )[-2:]
    if len(profiles) == 2:
        _ = run(["nvd", "diff", *profiles])


def on_term(_signum: int, _frame: FrameType | None) -> NoReturn:
    sys.exit(128 + signal.SIGTERM)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    _ = parser.add_argument(
        "--update",
        action="store_true",
        help="Run nix flake update before rebuilding",
    )
    args = parser.parse_args(namespace=Args())

    profile = os.environ.get("NIX_PROFILE", "")
    if not profile:
        print(
            "NIX_PROFILE is not set (e.g. mooping, work)",
            file=sys.stderr,
        )
        return 1

    _ = signal.signal(signal.SIGTERM, on_term)

    orig_dir = Path.cwd()
    os.chdir(DOTFILES)
    setup()

    try:
        if args.update:
            print("Updating flake...")
            _ = run(["nix", "flake", "update"], check=True)

        result = run(
            [
                "sudo",
                "darwin-rebuild",
                "switch",
                "--flake",
                f"{DOTFILES}#{profile}",
            ]
        )

        if result.returncode == 0:
            show_diff(profile)

        return result.returncode

    finally:
        cleanup()
        os.chdir(orig_dir)


if __name__ == "__main__":
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        sys.exit(130)
