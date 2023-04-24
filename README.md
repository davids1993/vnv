🐍 vnv - Python Virtual Environment Creator
vnv is a simple bash script that helps you create and activate Python virtual environments using pyenv and venv. This is helpful because it allows you to create isolated environments for different projects or applications, which means you can install specific versions of Python and packages without affecting other projects on your system. It also helps to ensure that your application or project has all the required dependencies installed without conflicts with other versions of packages.

Requirements
Before using vnv, you need to have both pyenv and Python installed on your system. Pyenv is a tool that allows you to easily switch between different versions of Python and also provides an easy way to install new Python versions.

Features
Creates a Python virtual environment with a single command.
Activates the virtual environment automatically.
Option to specify the Python version to use.
Option to clean up the folder by removing .git, .gitignore, local pyenv Python version, and venv.
Easy to use and customizable.
Installation
Clone the repository:
bash
Copy code
git clone https://github.com/<USERNAME>/vnv.git
Copy the vnv script to your $PATH:
bash
Copy code
cp vnv/vnv /usr/local/bin/
Make the script executable:
bash
Copy code
chmod +x /usr/local/bin/vnv
Usage
bash
Copy code
Usage: vnv [OPTIONS] [PYTHON_VERSION]
  Creates and activates a Python virtual environment using the specified PYTHON_VERSION
  If no PYTHON_VERSION is specified, creates and activates a Python virtual environment using the default Python version.
Options:
  -h, --help            Show this help message and exit
  -d, --deactivate      Deactivate the current virtual environment
  -c, --clean           Clean up the folder by removing .git, .gitignore, local pyenv python version, and venv
  -p, --path            Specify the path to the folder where the virtual environment should be created
Examples:

# Create a virtual environment using the default Python version
vnv

# Create a virtual environment using Python 3.9.5
vnv 3.9.5

# Clean up the folder
vnv -c

# Specify the path to the folder where the virtual environment should be created and specifiy the python version to use
vnv -p /path/to/folder 3.10.5

# Deactivate the current virtual environment
vnv -d

License
vnv is released under the MIT License.
