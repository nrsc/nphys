import os
import sys
import platform

# Check that Python is installed and that it's at least version 3.6
if sys.version_info < (3, 6):
    sys.exit("Python 3.6 or later is required.")

# Check that the operating system is supported
if platform.system() not in ["Windows", "Linux", "Darwin"]:
    sys.exit("This script can only be run on Windows, Linux, or macOS.")

def create_symlink(source, destination):
    # Get the absolute path of the directory where the script is located
    script_dir = os.path.dirname(os.path.abspath(__file__))

    # Construct the absolute path of the destination
    destination_path = os.path.join(script_dir, destination)

    if platform.system() == "Windows":
        os.system(f'mklink /D {destination_path} {source}')
    else:
        os.system(f'ln -s {source} {destination_path}')

# Server path
server_path = "/allen/programs/celltypes/workgroups/hct/SawchukS/exd"

# Create a symbolic link from the server path to a folder in the repo called 'rookery'
create_symlink(server_path, '.')
