#!/usr/bin/env python
# Custom tab bar for kitty.
# - draw_title(): tab title icons, loaded via {custom} in tab_title_template.
# - draw_tab(): built-in powerline tabs + session name pinned to the right
#   edge (requires tab_bar_style custom in kitty.conf).

import glob
import os
from pathlib import Path

from kitty.fast_data_types import Screen, get_boss, get_options, wcswidth
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    TabBarData,
    as_rgb,
    draw_tab_with_powerline,
)

# title prefix -> nerd font icon (all verified in JetBrainsMono NF)
# Longer, more specific prefixes first — first match wins.
TITLE_ICONS = (
    ("yazi", "", ""),
    ("nvim", "", ""),
    ("claude", "", "Agent"),
    ("codex", "", "Agent"),
    ("lazygit", "", "Git"),
    ("lg", "", "Git"),
    ("git", "", "Git"),
    ("yay", "", ""),
    ("top", "", "Top"),
)

TITLE_COLON_ICONS = (("IPython", ""),)
SSH_ICON = ""


def draw_title(data: dict) -> str:
    """Prepend a nerd font icon matched from the tab title text."""
    title = data["title"]
    for prefix, icon, alias in TITLE_ICONS:
        if title.startswith(prefix):
            title = title.replace(prefix, alias).strip()
            # return f"{icon} {title}" if title else f"{icon}"
            return f"{icon} {title}"

    title_parts = title.split(":")
    if len(title_parts) > 1:
        exec = title_parts[0].strip()
        path = title_parts[1].strip()
        if Path.home() == Path(path):
            dir_name = "~"
        else:
            dir_name = Path(path).name
        for prefix, icon in TITLE_COLON_ICONS:
            if prefix == exec:
                return f"{icon} {dir_name}"
        return f"{SSH_ICON} {dir_name}"
    title = title[title.rfind("/") + 1 :]
    return title


SESSION_ICON = ""


def _session_file(os_window_id: int) -> str:
    # Per OS window, and per kitty instance (pid) — one file per window.
    return f"/tmp/kitty-session-{os.getpid()}-{os_window_id}"


def session_name(os_window_id: int) -> str:
    """Session name set via the ctrl+alt+s shortcut, or '' when unset."""
    try:
        with open(_session_file(os_window_id), encoding="utf-8") as f:
            return f.read().strip()
    except OSError:
        return ""


def prune_session_files() -> None:
    """Delete session-name files of closed OS windows, so a name dies with
    its window."""
    try:
        live = frozenset(get_boss().os_window_map)
    except Exception:
        return
    for path in glob.glob(f"/tmp/kitty-session-{os.getpid()}-*"):
        try:
            wid = int(path.rsplit("-", 1)[1])
        except ValueError:
            continue
        if wid not in live:
            try:
                os.remove(path)
            except OSError:
                pass


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_tab_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    """Built-in powerline tabs; on the last tab also draw the session name
    pinned to the right edge of the bar."""
    end = draw_tab_with_powerline(
        draw_data, screen, tab, before, max_tab_length, index, is_last, extra_data
    )
    # Skip the session name while kitty measures tab lengths (layout pass) and
    # on vertical tab bars, where there is no right edge.
    if (
        is_last
        and not extra_data.for_layout
        and draw_data.tab_bar_edge not in ("left", "right")
    ):
        prune_session_files()
        name = session_name(draw_data.os_window_id)
        if name:
            label = f" {SESSION_ICON} {name} "
            x = screen.columns - wcswidth(label)
            if x > screen.cursor.x:
                screen.cursor.x = x
                screen.cursor.bg = as_rgb(int(draw_data.default_bg))
                screen.cursor.fg = as_rgb(int(get_options().active_tab_background))
                screen.cursor.bold = screen.cursor.italic = False
                screen.draw(label)
                # Park the cursor at the right edge so kitty's trailing
                # erase_in_line() doesn't clear the label.
                screen.cursor.x = screen.columns
    return end
