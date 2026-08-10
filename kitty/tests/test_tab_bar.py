"""Tests for tab_bar.py draw_title (title-prefix icon matching + slicing)."""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from tab_bar import _icon_from_title, draw_title


def render(title):
    return draw_title({"title": title})


def test_yazi_title_prefix_icon():
    assert render("Yazi: ch4ser") == '󰈞 Yazi: ch4ser'


def test_yazi_title_path_sliced():
    assert render("Yazi: /home/u/projects") == '󰈞 projects'


def test_nvim_title_icon_and_stripped_filename():
    assert render("nvim /home/u/a.txt") == ' /home/u/a.txt'


def test_nvim_title_without_leading_path():
    assert render("nvim") == ' nvim'


def test_lazygit_title_icon():
    assert render("lazygit /home/u/repo") == ' repo'


def test_tig_title_icon():
    assert render("tig") == ' tig'


def test_git_title_icon():
    assert render("git") == ' git'


def test_ssh_title_icon():
    assert render("ssh host") == ' ssh host'


def test_vim_title_icon():
    assert render("vim a.txt") == ' vim a.txt'


def test_shell_path_title_no_icon():
    assert render("/home/u/projects") == "projects"


def test_title_without_slash_untouched():
    assert render("shell") == "shell"


def test_unknown_title_no_icon():
    assert render("htop") == "htop"


def test_empty_title_renders_empty():
    assert render("") == ""


def test_title_prefix_is_case_sensitive():
    assert render("yazi") == "yazi"


def test_icon_from_title_matches_and_empty_for_unmatched():
    assert _icon_from_title("Yazi: x") == '󰈞'
    assert _icon_from_title("/home/u") == ""


if __name__ == '__main__':
    for name in sorted(globals()):
        if name.startswith('test_'):
            globals()[name]()
            print(f'PASS {name}')
    print('all tests passed')
