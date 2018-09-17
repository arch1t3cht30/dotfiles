#!/usr/bin/env python3

import sys
import os

FILENAME = "files.txt"

def moveln(name):
    d = os.path.dirname(name)
    if d:
        os.system("mkdir -p {0}".format(d))
    os.system("mv ~/{0} {0}".format(name))
    doln(name)

def doln(name):
    d = os.path.dirname(os.path.join("~", name))
    if d:
        os.system("mkdir -p {0}".format(d))
    os.system("ln -sf {0} {1}"
              .format(os.path.join(os.getcwd(), name),
                                   os.path.join("~", name)))


def get_list():
    with open(FILENAME, "r") as f:
        return [s.strip() for s in f.readlines()]

def add_to_list(names):
    all_names = sorted(list(set(names).union(set(get_list()))))

    with open(FILENAME, "w") as f:
        f.writelines(s + "\n" for s in all_names)

if __name__ == "__main__":
    if len(sys.argv) < 2 or sys.argv[1] not in ["create", "extract"]:
        print("Usage: {} <create/extract> [FILES]")
        exit()
    if sys.argv[1] == "extract":
        for name in get_list():
            doln(name)

    elif sys.argv[1] == "create":
        for item in sys.argv[2:]:
            moveln(item)
        add_to_list(sys.argv[2:])
