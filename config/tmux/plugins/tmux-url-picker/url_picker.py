#!/usr/bin/env python3
"""tmux URL picker — collect URLs from the current pane, then open or copy one."""

import os
import re
import shlex
import subprocess
import sys
import tempfile
from pathlib import Path

HEADER = "Enter: Open URL / CTRL-Y: Copy to clipboard"
COPY_KEY = "ctrl-y"
URL_RE = re.compile(
    r"(?:https?|file)://[-a-zA-Z0-9@:%_+.~#?&/=]+[-a-zA-Z0-9@%_+.~#?&/=!]+"
)
ENTRY_RE = re.compile(r"^\d+: (?P<url>.+)$")

# Television adds title and border padding around the input header.
HEADER_PADDING = 12
MAX_POPUP_WIDTH = 100
# Television needs room for its input, results, and status panels. Keep a
# minimum height so it does not hide the input header.
PANEL_HEIGHT = 7
MIN_POPUP_HEIGHT = 10


def tmux(*args: str, **kwargs) -> subprocess.CompletedProcess:
    return subprocess.run(["tmux", *args], **kwargs)


def pane_urls() -> list[str]:
    pane = tmux("capture-pane", "-J", "-p", capture_output=True, text=True).stdout
    # Newest URLs first, keeping the first occurrence of each.
    return list(dict.fromkeys(reversed(URL_RE.findall(pane))))


def open_url(url: str) -> None:
    subprocess.run(["open", url])


def copy_url(url: str) -> None:
    subprocess.run(["pbcopy"], input=url, text=True)


def select(urls_file: Path) -> None:
    urls = urls_file.read_text().splitlines()
    entries = "".join(f"{index}: {url}\n" for index, url in enumerate(urls, 1))

    result = subprocess.run(
        [
            "tv",
            "--no-sort",
            "--no-status-bar",
            "--input-header",
            HEADER,
            "--expect",
            COPY_KEY,
        ],
        input=entries,
        # Television draws its interface on stderr, so only capture stdout.
        stdout=subprocess.PIPE,
        text=True,
    )

    lines = result.stdout.splitlines()
    # --expect prefixes the output with the key used to confirm the selection.
    key = lines.pop(0) if lines and not ENTRY_RE.match(lines[0]) else ""

    for line in lines:
        match = ENTRY_RE.match(line)
        if not match:
            continue
        url = match["url"]
        if key == COPY_KEY:
            copy_url(url)
        else:
            open_url(url)


def show_popup(urls: list[str], urls_file: Path) -> None:
    width = min(
        max(len(HEADER) + HEADER_PADDING, *(len(url) for url in urls)),
        MAX_POPUP_WIDTH,
    )
    height = max(len(urls) + PANEL_HEIGHT, MIN_POPUP_HEIGHT)
    script = Path(__file__).resolve()

    tmux(
        "display-popup",
        "-E",
        "-w",
        str(width),
        "-h",
        str(height),
        f"{shlex.quote(str(script))} select {shlex.quote(str(urls_file))}",
    )


def pick() -> None:
    urls = pane_urls()

    if not urls:
        tmux("display-message", "No URLs found")
        return
    if len(urls) == 1:
        open_url(urls[0])
        return

    fd, name = tempfile.mkstemp(prefix="tmux-url-picker-")
    urls_file = Path(name)
    try:
        with os.fdopen(fd, "w") as handle:
            handle.write("\n".join(urls) + "\n")
        show_popup(urls, urls_file)
    finally:
        urls_file.unlink(missing_ok=True)


def main() -> int:
    if sys.argv[1:2] == ["select"]:
        select(Path(sys.argv[2]))
    else:
        pick()

    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        sys.exit(130)
