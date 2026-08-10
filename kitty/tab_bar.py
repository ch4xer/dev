#!/usr/bin/env python
# Custom tab bar titles for kitty — loaded via {custom} in tab_title_template.

# title prefix -> nerd font icon (all verified in JetBrainsMono NF)
# Longer, more specific prefixes first — first match wins.
TITLE_ICONS = (
    ("Yazi:", "󰈞"),  #  md-file_find
    ("nvim", ""),  #  linux-neovim
    ("lazygit", ""),  #  dev-git_branch
    ("tig", ""),  #  dev-git_commit
    ("git", ""),  #  cod-git_branch
    ("ssh", ""),  #  dev-ssh
    ("vim", ""),  #  dev-vim
)


def _icon_from_title(title: str) -> str:
    for prefix, icon in TITLE_ICONS:
        if title.startswith(prefix):
            return icon
    return ""


def draw_title(data: dict) -> str:
    """Prepend a nerd font icon matched from the tab title text."""
    title = data["title"]
    # keep existing title behavior: basename of path, strip 'nvim ' prefix
    if title.startswith("nvim "):
        title = title[title.rfind(" ") + 1 :]
    else:
        title = title[title.rfind("/") + 1 :]
    icon = _icon_from_title(data["title"])
    return f"{icon} {title}" if icon else title
