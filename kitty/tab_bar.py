#!/usr/bin/env python
# Custom tab bar titles for kitty — loaded via {custom} in tab_title_template.

# exe basename -> nerd font icon (all verified in JetBrainsMono NF)
ICONS = {
    'nvim': '',       #  dev-neovim
    'vim': '',         #  dev-vim
    'ssh': '',         #  dev-ssh
    'yazi': '󰈞',       #  md-file_find
    'git': '',         #  cod-git_branch
    'lazygit': '', #  dev-git_branch
    'tig': '',         #  dev-git_commit
}


def draw_title(data: dict) -> str:
    """Prepend a nerd font icon for the tab's active program."""
    title = data['title']
    # keep existing title behavior: basename of path, strip 'nvim ' prefix
    if title.startswith('nvim '):
        title = title[title.rfind(' ') + 1:]
    else:
        title = title[title.rfind('/') + 1:]
    icon = ICONS.get(data['tab'].active_exe, '')
    return f'{icon} {title}' if icon else title
