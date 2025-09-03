import os
import shutil
import shlex
from pathlib import Path
from importlib import reload
import functools
import functools as ft
import itertools
import itertools as it
import subprocess
import subprocess as sp
import re
from pprint import pprint
from pprint import pprint as pp
from collections.abc import Iterable


def iter_with(obj):
    with obj:
        yield from obj

def iter_print(iter):
    for line in iter:
        print(line)


def take(iter, n):
    """take generator for lazily reading a sequence from an iterator"""
    for _ in range(n):
        yield next(iter)

class dotdict(dict):
    __getattr__ = dict.get
    __setattr__ = dict.__setitem__
    __delattr__ = dict.__delitem__

class Shell(dotdict):

    def __init__(self):
        super().__init__(self)
        def _ls():
            iter_print(os.listdir())
        self["ls"] = _ls
        self["cd"] = os.chdir
        self["mv"] = shutil.move
        self["cp"] = shutil.copy2
        self["cpr"] = shutil.copytree
        self["rm"] = os.remove
        self["rmr"] = shutil.rmtree
        self["tarc"] = shutil.make_archive
        self["tarx"] = shutil.unpack_archive

    # cd = os.chdir
    # mv = shutil.move
    # cp = shutil.copy2
    # cpr = shutil.copytree
    # rm = os.remove
    # rmr = shutil.rmtree
    # tarc = shutil.make_archive
    # tarx = shutil.unpack_archive

    @staticmethod
    def nvim(*args):
        target = ["nvim"]
        if args:
            target.extend(args)
        return sp.run(target)

    @staticmethod
    def run(target, *args, **kwargs):
        try:
            if isinstance(target, str):
                return sp.run(shlex.split(target), *args, **kwargs)
            return sp.run(target, *args, **kwargs)
        except FileNotFoundError as e:
            print(e)

    def mkcmd(self, cmd):
        return ft.partial(self.run, cmd)

    def __call__(self, *args, **kwargs):
        return self.run(*args, **kwargs)

sh = Shell()

