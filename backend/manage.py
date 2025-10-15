#!/usr/bin/env python3
"""Django's command-line utility for administrative tasks."""
import os
import sys
from common.database import check_db_connection


def main():
    """Run administrative tasks."""
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'mysite.settings')
    
    # Set default port to 7001 only if runserver is specified without port
    if len(sys.argv) == 2 and sys.argv[1] == 'runserver':
        sys.argv.append('7001')
    elif len(sys.argv) == 1:
        sys.argv.extend(['runserver', '7001'])
    
    try:
        check_db_connection()
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    execute_from_command_line(sys.argv)


if __name__ == '__main__':
    main()
