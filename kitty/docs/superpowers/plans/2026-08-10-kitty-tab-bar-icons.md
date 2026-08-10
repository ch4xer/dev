# Kitty Tab Bar Nerd Font Icons Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a nerd font icon to kitty tab bar titles, mapped from the active program of each tab (nvim, vim, ssh, yazi, git, lazygit, tig).

**Architecture:** A small standalone `tab_bar.py` module in the kitty config dir defines `draw_title(data)`, which kitty calls through the `{custom}` field in `tab_title_template`. The module needs no kitty imports — it reads `data['title']` and `data['tab'].active_exe`, slices the title to its basename (existing behavior), and prepends an icon from a codepoint dict. `tab_bar_style powerline` and all builtin tab drawing stay untouched.

**Tech Stack:** Python 3 (stdlib only), kitty config, JetBrainsMono Nerd Font (icons verified present).

## Global Constraints

- Icon codepoints are FIXED by the spec table — do not substitute other codepoints. nvim U+E83A, vim U+E7C5, ssh U+E8B1, yazi U+F021E (above BMP — must be written as the literal glyph, a `\U000f021e` escape, or a 2-surrogate pair; `\uf021e` is WRONG), git U+EC6F, lazygit U+E725, tig U+E729.
- `tab_bar.py` must be standalone: no imports outside the standard library.
- `kitty.conf` change is limited to the `tab_title_template` line — nothing else.
- Do NOT define `draw_tab` in `tab_bar.py`; only `draw_title`.
- `tab_bar_basic.py` is deleted (kitty never loads that filename).
- All work happens in `/home/ch4ser/Projects/Config/dev/kitty` (symlinked as `~/.config/kitty`).

---

### Task 1: Write the failing test for `draw_title`

**Files:**
- Create: `tests/test_tab_bar.py`

**Interfaces:**
- Consumes: nothing yet — the module does not exist.
- Produces: `render(exe, title)` helper. Later tasks rely on `draw_title({'title': str, 'tab': obj})` returning a str where `obj.active_exe` is the program basename.

- [ ] **Step 1: Create `tests/test_tab_bar.py`** with exactly this content (glyphs are literal — copy them as-is):

```python
"""Tests for tab_bar.py draw_title (icon mapping + title slicing)."""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from tab_bar import draw_title


class FakeTab:
    def __init__(self, active_exe):
        self.active_exe = active_exe


def render(exe, title):
    return draw_title({'title': title, 'tab': FakeTab(exe)})


def test_nvim_shows_icon_and_stripped_filename():
    assert render('nvim', 'nvim /home/u/a.txt') == '<N> /home/u/a.txt'


def test_known_program_with_path_title():
    assert render('ssh', '/home/u/projects') == '<S> projects'


def test_yazi_icon():
    assert render('yazi', '/home/u/projects') == '<Y> projects'


def test_lazygit_icon():
    assert render('lazygit', '/home/u/repo') == '<L> repo'


def test_unknown_program_no_icon():
    assert render('htop', '/home/u/projects') == 'projects'


def test_empty_exe_no_icon():
    assert render('', '/home/u/projects') == 'projects'


def test_title_without_slash_untouched():
    assert render('zsh', 'shell') == 'shell'


def test_nvim_title_without_leading_path():
    assert render('nvim', 'nvim') == '<N> nvim'


if __name__ == '__main__':
    for name in sorted(globals()):
        if name.startswith('test_'):
            globals()[name]()
            print(f'PASS {name}')
    print('all tests passed')
```

Where the `<N>`/`<S>`/`<Y>`/`<L>` placeholders are the LITERAL glyphs from the mapping table:

| placeholder | program | literal glyph | codepoint |
|---|---|---|---|
| `<N>` | nvim |  | U+E83A dev-neovim |
| `<S>` | ssh |  | U+E8B1 dev-ssh |
| `<Y>` | yazi | 󰈞 | U+F021E md-file_find |
| `<L>` | lazygit |  | U+E725 dev-git_branch |

- [ ] **Step 2: Run the test and verify it fails**

Run: `python3 tests/test_tab_bar.py`
Expected: FAIL with `ModuleNotFoundError: No module named 'tab_bar'`

- [ ] **Step 3: Commit the failing test**

```bash
git add tests/test_tab_bar.py
git commit -m "test: tab bar draw_title icon mapping and title slicing"
```

### Task 2: Implement `tab_bar.py` to make the test pass

**Files:**
- Create: `tab_bar.py` (repo root — this is the file kitty loads as `~/.config/kitty/tab_bar.py`)

**Interfaces:**
- Consumes: test helper `render(exe, title)` from Task 1.
- Produces: `draw_title(data: dict) -> str` — the module-level function kitty calls through `{custom}`. `data['title']` is the raw tab title str; `data['tab'].active_exe` is the active program basename str (may be empty).

- [ ] **Step 1: Create `tab_bar.py`** with exactly this content (glyphs are literal — copy them as-is):

```python
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
```

(The `` etc. placeholders are the LITERAL glyphs from the Task 1 table — same glyphs as in the test file.)

- [ ] **Step 2: Run the test and verify it passes**

Run: `cd /home/ch4ser/Projects/Config/dev/kitty && python3 tests/test_tab_bar.py`
Expected: all 8 `PASS` lines, then `all tests passed`.

- [ ] **Step 3: Commit**

```bash
git add tab_bar.py
git commit -m "feat: nerd font icons in tab bar per active program"
```

### Task 3: Wire `{custom}` into kitty.conf and remove dead weight

**Files:**
- Modify: `kitty.conf:22` — the `tab_title_template` line
- Delete: `tab_bar_basic.py`

**Interfaces:**
- Consumes: `tab_bar.py` from Task 2 (loaded by kitty only when the template references `{custom}`).
- Produces: a working tab bar — no further code dependencies.

- [ ] **Step 1: Replace the `tab_title_template` line**

Current line 22 of `kitty.conf`:
```
tab_title_template "{'  ' + title[title.rfind(' ')+1:] if (title.startswith('nvim ')) else title[title.rfind('/')+1:]}"
```

Replace with:
```
tab_title_template "{custom}"
```

The slicing + icon logic now lives entirely in `tab_bar.py`. All other lines untouched.

- [ ] **Step 2: Delete `tab_bar_basic.py`**

Run: `git rm tab_bar_basic.py` (the file is untracked — plain `rm` + no commit entry is fine; use `git status` to confirm it's gone from the working tree)

- [ ] **Step 3: Sanity-check the config syntax**

Run: `kitty --config kitty.conf --version` (or `kitty +complete bash` — any command that parses the config without error)
Expected: normal kitty output, no parse errors.

- [ ] **Step 4: Commit**

```bash
git add kitty.conf
git commit -m "feat: use {custom} tab title template with nerd font icons"
```

### Task 4: Manual verification in a running kitty

**Files:** none.

**Interfaces:**
- Consumes: the fully wired config from Tasks 2-3.

- [ ] **Step 1: Reload the kitty config**

The tab bar module is cached per kitty process (`run_once`), but kitty's config reload path calls `tab_bar.clear_caches()` (verified in boss.py:3220-3221). Press `ctrl+shift+f5` (default `reload_config` binding) in the running kitty. If that does not pick up the change, restart kitty as a fallback.

- [ ] **Step 2: Open one tab per mapped program and eyeball**

In separate tabs (or one tab each): run `nvim`, `ssh host`, `yazi`, `lazygit`, and a plain shell (`zsh`). Expected:

- nvim tab: `<N> <filename>` (icon + filename, no full path)
- ssh tab: `<S> <basename-of-cwd>`
- yazi tab: `<Y> <basename>`
- lazygit tab: `<L> <basename>`
- plain shell tab: basename only, no icon
- active and inactive tabs both show the same title text (kitty recolors, it does not redraw text)

- [ ] **Step 3: If any icon shows as a missing-glyph box**

Run `python3 -c "from tab_bar import ICONS; print(len(set(ord(i) for i in ICONS.values())))"` — expected `7`, confirming the file bytes are intact, then check `kitty --debug-config | grep -i tab_title` shows `{custom}`.
