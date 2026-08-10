# Kitty Tab Bar Nerd Font Icons — Design

Date: 2026-08-10
Status: Approved

## Goal

Add a nerd font icon to kitty tab bar titles, mapped from the active program
name of each tab (e.g. nvim, ssh, yazi, git tools).

## Context

- `~/.config/kitty` is a symlink to this repo (`/home/ch4ser/Projects/Config/dev/kitty`).
- Current setup: `tab_bar_style powerline` with a `tab_title_template` eval
  expression that (a) injects the `linux-neovim` icon (U+F36F) for titles
  starting with `nvim `, and (b) slices titles to the basename of the last
  `/`. The shell integration sets titles to the cwd path; nvim sets
  `nvim <file>`.
- Kitty loads a custom module named `tab_bar.py` from the config dir. It may
  define `draw_title(data)`, invoked through the `{custom}` field in
  `tab_title_template`. `data['tab'].active_exe` is the basename of the
  active window's executable. A custom `draw_tab` is only used with
  `tab_bar_style custom`, so the builtin powerline drawing is untouched.
- `tab_bar_basic.py` (a copy of kitty's builtin module) is dead weight —
  kitty never loads that filename. It will be deleted.
- All chosen codepoints were verified present in the installed
  JetBrainsMono Nerd Font.

## Decisions (from brainstorming)

| Question | Decision |
|---|---|
| Programs with icons | nvim, vim, ssh, yazi, git, lazygit, tig |
| Icon set | Proposed set approved (below) |
| Unknown programs | No icon, just the sliced title |
| Title text | Keep current basename slicing + `nvim ` prefix strip |
| Approach | Small custom `tab_bar.py` with `draw_title()` only; template becomes `{custom}` |

## Icon mapping (all U+ codepoints verified in font)

| Program | Icon | Codepoint | Glyph name |
|---|---|---|---|
| nvim |  | U+E83A | dev-neovim |
| vim |  | U+E7C5 | dev-vim |
| ssh |  | U+E8B1 | dev-ssh |
| yazi |  | U+F021E | md-file_find |
| git |  | U+EC6F | cod-git_branch |
| lazygit |  | U+E725 | dev-git_branch |
| tig |  | U+E729 | dev-git_commit |

## Implementation

### New file: `tab_bar.py` (repo root, symlinked to `~/.config/kitty/`)

```python
#!/usr/bin/env python
# Custom tab bar titles for kitty — loaded via {custom} in tab_title_template.

# exe basename -> nerd font icon (all verified in JetBrainsMono NF)
ICONS = {
    'nvim': '',   #  dev-neovim
    'vim': '',   #  dev-vim
    'ssh': '',   #  dev-ssh
    'yazi': '󰈞',   #  md-file_find
    'git': '',   #  cod-git_branch
    'lazygit': '',   #  dev-git_branch
    'tig': '',   #  dev-git_commit
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
```

### kitty.conf change

```
tab_title_template "{custom}"
```

Replace the existing eval expression. Everything else in kitty.conf unchanged.

### Delete

`tab_bar_basic.py` — unused by kitty, superseded.

## Behavior & edge cases

- Unknown program → no icon, sliced title only.
- Multi-window tab → icon of the tab's active window (`active_exe`).
- `active_exe` empty (`None`/no window) → `ICONS.get` returns `''` → no icon.
- If `draw_title` raises, kitty's `apply_title_template` try/except falls back
  to the raw tab title — the tab bar cannot break.
- New programs later: one line added to `ICONS`.

## Verification

1. Unit check: call `draw_title` with sample titles
   (`'nvim /home/u/a.txt'`, `'/home/u/projects'`, `'yazi'`) and assert
   expected slicing + icon output.
2. Manual: restart kitty (the module is cached at startup; config reload is
   not enough), then open nvim, ssh, yazi, lazygit tabs and eyeball icons.