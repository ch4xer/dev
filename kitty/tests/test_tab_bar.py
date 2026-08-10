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


if __name__ == '__main__':
    for name in sorted(globals()):
        if name.startswith('test_'):
            globals()[name]()
            print(f'PASS {name}')
    print('all tests passed')
