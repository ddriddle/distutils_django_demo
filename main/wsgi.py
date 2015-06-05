"""
WSGI config for main project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/1.8/howto/deployment/wsgi/
"""

import os
import sys

from sdg.scl import SDGCollections

SDGCollections.enable('python27', 'sdg_2015a_python27')

this_dir = os.path.dirname(__file__)
BASE_DIR = os.path.abspath(os.path.join(this_dir, '..'))
sys.path.insert(0, BASE_DIR)

from django.core.wsgi import get_wsgi_application

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "main.settings")

application = get_wsgi_application()
