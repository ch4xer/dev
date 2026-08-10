#!/usr/bin/env python
# Custom tab bar titles for kitty — loaded via {custom} in tab_title_template.

import os

# exe basename -> nerd font icon (all verified in JetBrainsMono NF)
ICONS = {
    'nvim': '',       #  dev-neovim
    'vim': '',         #  dev-vim
    'ssh': '',         #  dev-ssh
    'yazi': '󰈞',       #  md-file_find
    'git': '',         #  cod-git_branch
    'lazygit': '', #  dev-git_branch
}


def _icon_from_processes(processes: list[dict]) -> str:
    """Pick the newest process in the group whose exe we know.

    kitty's active_exe takes the highest-pid process, which can be a
    transient helper (e.g. a zombie previewer with an unreadable cmdline)
    masking the real program. Scan the whole group instead, newest (highest
    pid) first. Note: a known program spawned as a child of another known
    program (e.g. lazygit spawning git) resolves to the newest one — this
    matches kitty's own newest-first philosophy.
    """
    for proc in sorted(processes, key=lambda p: p['pid'], reverse=True):
        cmdline = proc.get('cmdline')
        if cmdline:
            exe = os.path.basename(cmdline[0])
            if exe in ICONS:
                return ICONS[exe]
    return ''


def _scan_icon(data: dict) -> str:
    try:
        from kitty.fast_data_types import get_boss
        tab = get_boss().tab_for_id(data['tab'].tab_id)
        w = tab.active_window if tab else None
        if w is not None:
            return _icon_from_processes(w.child.foreground_processes)
    except Exception:
        pass
    return ''


def draw_title(data: dict) -> str:
    """Prepend a nerd font icon for the tab's active program."""
    title = data['title']
    # keep existing title behavior: basename of path, strip 'nvim ' prefix
    if title.startswith('nvim '):
        title = title[title.rfind(' ') + 1:]
    else:
        title = title[title.rfind('/') + 1:]
    icon = ICONS.get(data['tab'].active_exe, '')
    if not icon:
        icon = _scan_icon(data)
    return f'{icon} {title}' if icon else title
