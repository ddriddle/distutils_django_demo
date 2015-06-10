import os

from glob import glob
from os.path import join, relpath
from setuptools import setup, find_packages

def graft(dst, src):
    """
    This function is a convenience function that allows one to easily
    graft a source directory src of data files into an rpm at a user
    specified directory dst.

    Example usage:

    data_files = graft('/etc/myprog', 'config')

    data_files = [('/etc', ['foobar.ini'])] + \
                 graft('/etc/myprog', 'config') + \
                 graft('/etc/init.d', 'init_files') + \

    This function works by taking a source directory src and
    generating a list of tuples of the form ('directory', ['file1',
    'file2', ...]). This list can be set directly to the variable
    data_files or merged with multiple callings to the graft function.
    """
    data_file_list = []

    for root, _, src_files in os.walk(src):
        directory = dst if root == src else join(dst, relpath(root, src))
        files = [join(root, f) for f in src_files]

        # Skip empty directories
        if files:
            data_file_list.append((directory, files))

    return data_file_list

setup(
    name = "polls",
    version = "0.1",
    packages = find_packages('src'),
    package_dir = {'':'src'},
    include_package_data = True,
    scripts = ['src/bin/manage.py'],
    test_suite = "runtests.runtests",
    install_requires = ['Django>=1.8'],
    tests_require = ['Django>=1.8'],

    data_files = [
        ('', ['src/db.sqlite3']),
        ('apache',    ['src/apache/wsgi.conf']),
        ('bin',    ['src/bin/manage.py']),
        ('static',    glob('src/static/*')),
    ] + graft('templates', 'src/templates')
      + graft('static', 'src/static')
)
