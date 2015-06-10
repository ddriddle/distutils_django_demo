#!/usr/bin/env python
# This file only exists to allow python setup.py test to work.
import os
import sys

def runtests():
    BASE_DIR = os.path.abspath('src')
    sys.path.insert(0, BASE_DIR)
    os.chdir(BASE_DIR)

    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "main.settings")

    from django.core.management import execute_from_command_line

    sys.exit(execute_from_command_line(argv=['', 'test']))

if __name__ == '__main__':
    runtests()
