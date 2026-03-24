"""Setup script for installing Flask dependencies."""

import subprocess
import sys

if __name__ == '__main__':
    subprocess.check_call([sys.executable, '-m', 'pip', 'install', '-r', 'requirements.txt'])
    print('Installation complete. Run `python app.py` to start the server.')
