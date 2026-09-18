#!/usr/bin/env python3
"""tmux URL picker — collect URLs from the current pane, then open or copy one."""

from __future__ import annotations

import re
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


def run_television(urls: list[str]) -> tuple[str, str | None]:
    """Return the key used to confirm the selection and the chosen URL."""
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

    key = ""
    url = None
    for line in result.stdout.splitlines():
        match = ENTRY_RE.match(line)
        if match:
            url = match["url"]
        else:
            # --expect prefixes the output with the key used to confirm.
            key = line
    return key, url


def select(urls_file: Path) -> None:
    key, url = run_television(urls_file.read_text().splitlines())
    if url is None:
        return
    copy_url(url) if key == COPY_KEY else open_url(url)


def popup_size(urls: list[str]) -> tuple[int, int]:
    width = min(
        max(len(HEADER) + HEADER_PADDING, max(map(len, urls))),
        MAX_POPUP_WIDTH,
    )
    height = max(len(urls) + PANEL_HEIGHT, MIN_POPUP_HEIGHT)
    return width, height


def show_popup(urls: list[str], urls_file: Path) -> None:
    width, height = popup_size(urls)
    script = Path(__file__).resolve()

    # display-popup -E blocks until the popup exits, so urls_file stays alive.
    tmux(
        "display-popup",
        "-E",
        "-w",
        str(width),
        "-h",
        str(height),
        str(script),
        "select",
        str(urls_file),
    )


def pick() -> None:
    urls = pane_urls()

    if not urls:
        tmux("display-message", "No URLs found")
        return
    if len(urls) == 1:
        open_url(urls[0])
        return

    with tempfile.TemporaryDirectory(prefix="tmux-url-picker-") as tmpdir:
        urls_file = Path(tmpdir) / "urls"
        urls_file.write_text("\n".join(urls) + "\n")
        show_popup(urls, urls_file)


def main(argv: list[str]) -> int:
    if argv[:1] == ["select"]:
        select(Path(argv[1]))
    else:
        pick()

    return 0


if __name__ == "__main__":
    try:
        sys.exit(main(sys.argv[1:]))
    except KeyboardInterrupt:
        sys.exit(130)
