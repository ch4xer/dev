# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# A simple command for demonstration purposes follows.
# -----------------------------------------------------------------------------

from __future__ import absolute_import, division, print_function

# You can import any python module as needed.
import os

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import Command
from plugins.ranger_udisk_menu.mounter import mount

# Any class that is a subclass of "Command" will be integrated into ranger as a
# command.  Try typing ":my_edit<ENTER>" in ranger!


class fzf_select(Command):
    """
    :fzf_select
    Find a file using fzf.
    With a prefix argument to select only directories.

    See: https://github.com/junegunn/fzf
    """

    def execute(self):
        import subprocess
        import os
        from ranger.ext.get_executables import get_executables

        if "fzf" not in get_executables():
            self.fm.notify("Could not find fzf in the PATH.", bad=True)
            return

        fd = None
        if "fdfind" in get_executables():
            fd = "fdfind"
        elif "fd" in get_executables():
            fd = "fd"

        if fd is not None:
            hidden = "--hidden" if self.fm.settings.show_hidden else ""
            exclude = "--no-ignore-vcs --exclude={.wine,.git,.idea,.vscode,.sass-cache,node_modules,build,.local,.steam,.m2,.rangerdir,.ssh,.ghidra,.mozilla,.cache} --exclude '*.py[co]' --exclude '__pycache__'"
            only_directories = "--type directory" if self.quantifier else ""
            fzf_default_command = "{} --follow {} {} {} --color=always".format(
                fd, hidden, exclude, only_directories
            )
        else:
            hidden = (
                "-false" if self.fm.settings.show_hidden else r"-path '*/\.*' -prune"
            )
            exclude = r"\( -name '\.git' -o -iname '\.*py[co]' -o -fstype 'dev' -o -fstype 'proc' \) -prune"
            only_directories = "-type d" if self.quantifier else ""
            fzf_default_command = (
                "find -L . -mindepth 1 {} -o {} -o {} -print | cut -b3-".format(
                    hidden, exclude, only_directories
                )
            )

        env = os.environ.copy()
        env["FZF_DEFAULT_COMMAND"] = fzf_default_command
        env[
            "FZF_DEFAULT_OPTS"
        ] = '--height=100% --layout=reverse --ansi --preview="{}"'.format(
            """
           (
               ~/Tools/Other/fzf-scope.sh {} ||
               #batcat --color=always {} ||
               #bat --color=always {} ||
               #cat {} ||
               tree -ahpCL 3 -I '.git' -I '*.py[co]' -I '__pycache__' {}
           ) 2>/dev/null | head -n 100
       """
        )

        fzf = self.fm.execute_command(
            "fzf --no-multi", env=env, universal_newlines=True, stdout=subprocess.PIPE
        )
        stdout, _ = fzf.communicate()
        if fzf.returncode == 0:
            selected = os.path.abspath(stdout.strip())
            if os.path.isdir(selected):
                self.fm.cd(selected)
            else:
                self.fm.select_file(selected)


class fzf_select_tag_paper(Command):
    """
    Find a paper folder using fzf.
    """

    def execute(self):
        import subprocess
        import os
        from ranger.ext.get_executables import get_executables

        self.fm.cd("/home/ch4ser/Documents/Papers")
        if "fzf" not in get_executables():
            self.fm.notify("Could not find fzf in the PATH.", bad=True)
            return

        if "fd" not in get_executables():
            self.fm.notify("Could not find fd in the PATH.", bad=True)
            return

        fzf_default_command = """fd --follow -t f --color=always -e tag --hidden"""

        env = os.environ.copy()
        env["FZF_DEFAULT_COMMAND"] = fzf_default_command
        env["FZF_DEFAULT_OPTS"] = "--height=100% --layout=reverse --ansi "

        fzf = self.fm.execute_command(
            "fzf --no-multi", env=env, universal_newlines=True, stdout=subprocess.PIPE
        )
        stdout, _ = fzf.communicate()
        if fzf.returncode == 0:
            selected = os.path.abspath(stdout.strip())
            if os.path.isdir(selected):
                self.fm.cd(selected)
            else:
                self.fm.select_file(selected)


class set_cut_flag(Command):
    flag_file_name = "cut_flag"

    def execute(self):
        fname = self.fm.datapath(self.flag_file_name)
        try:
            with open(fname, "w", encoding="utf-8") as f:
                f.write("1")
        except:
            return self.fm.notify(
                "Cannot write %s" % (fname or self.flag_file_name), bad=True
            )
        return None


class custom_cut(Command):
    flag_file_name = "cut_flag"

    def execute(self):
        fname = self.fm.datapath(self.flag_file_name)
        try:
            with open(fname, "r+", encoding="utf-8") as f:
                flag = int(f.read())
                assert flag == 0 | flag == 1
                f.write("0")
                if flag == 1:
                    self.fm.do_cut = True
        except Exception as e:
            return self.fm.notify(e)


class unset_cut_flag(Command):
    flag_file_name = "cut_flag"

    def execute(self):
        fname = self.fm.datapath(self.flag_file_name)
        try:
            with open(fname, "w", encoding="utf-8") as f:
                f.write("0")
        except Exception as e:
            return self.fm.notify(e)
        return None
