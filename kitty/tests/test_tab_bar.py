"""Tests for tab_bar.py draw_title (icon mapping + title slicing)."""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from tab_bar import _icon_from_processes, draw_title

class FakeTab:
    def __init__(self, active_exe):
        self.active_exe = active_exe

def render(exe, title):
    return draw_title({'title': title, 'tab': FakeTab(exe)})

def test_nvim_shows_icon_and_stripped_filename():
    assert render('nvim', 'nvim /home/u/a.txt') == ' /home/u/a.txt'

def test_known_program_with_path_title():
    assert render('ssh', '/home/u/projects') == ' projects'

def test_yazi_icon():
    assert render('yazi', '/home/u/projects') == '󰈞 projects'

def test_lazygit_icon():
    assert render('lazygit', '/home/u/repo') == ' repo'

def test_unknown_program_no_icon():
    assert render('htop', '/home/u/projects') == 'projects'

def test_empty_exe_no_icon():
    assert render('', '/home/u/projects') == 'projects'

def test_title_without_slash_untouched():
    assert render('zsh', 'shell') == 'shell'

def test_nvim_title_without_leading_path():
    assert render('nvim', 'nvim') == ' nvim'

def test_scan_finds_known_program_behind_cmdline_less_process():
    # the confirmed bug: kitty's max-pid heuristic picked a cmdline-less
    # zombie helper, masking yazi in the same process group
    procs = [
        {'pid': 1049728, 'cmdline': ['/usr/bin/yazi']},
        {'pid': 1049773, 'cmdline': None},
    ]
    assert _icon_from_processes(procs) == '󰈞'

def test_scan_prefers_highest_pid_known_program():
    procs = [
        {'pid': 5, 'cmdline': ['/usr/bin/nvim']},
        {'pid': 9, 'cmdline': ['/usr/bin/yazi']},
    ]
    assert _icon_from_processes(procs) == '󰈞'

def test_scan_empty_group_no_icon():
    assert _icon_from_processes([]) == ''

def test_scan_unknown_programs_no_icon():
    procs = [
        {'pid': 5, 'cmdline': ['/bin/zsh']},
        {'pid': 6, 'cmdline': ['/usr/bin/ls']},
    ]
    assert _icon_from_processes(procs) == ''

def test_scan_skips_process_with_empty_cmdline():
    procs = [
        {'pid': 6, 'cmdline': []},
        {'pid': 5, 'cmdline': ['/usr/bin/lazygit']},
    ]
    assert _icon_from_processes(procs) == ''

def test_scan_priority_is_deterministic_regardless_of_input_order():
    # input order is not guaranteed (procfs readdir order); highest pid must win
    procs = [
        {'pid': 9, 'cmdline': ['/usr/bin/yazi']},
        {'pid': 5, 'cmdline': ['/usr/bin/nvim']},
    ]
    assert _icon_from_processes(procs) == '󰈞'

def test_draw_title_falls_back_to_scan_when_direct_exe_misses():
    import tab_bar
    orig = tab_bar._scan_icon
    tab_bar._scan_icon = lambda data: '󰈞'
    try:
        assert draw_title({'title': 'Yazi: ch4ser', 'tab': FakeTab('zsh')}) == '󰈞 Yazi: ch4ser'
    finally:
        tab_bar._scan_icon = orig

def test_draw_title_direct_hit_does_not_scan():
    import tab_bar
    orig = tab_bar._scan_icon

    def boom(data):
        raise AssertionError('scan must not run when active_exe matches')

    tab_bar._scan_icon = boom
    try:
        assert render('nvim', 'nvim /a/b.txt') == ' /a/b.txt'
    finally:
        tab_bar._scan_icon = orig

if __name__ == '__main__':
    for name in sorted(globals()):
        if name.startswith('test_'):
            globals()[name]()
            print(f'PASS {name}')
    print('all tests passed')
