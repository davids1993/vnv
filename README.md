# vnv
Shell Script to set up a python environment

# 🐍 vnv - Python Virtual Environment Creator

`vnv` is a simple bash script that helps you create and activate Python virtual environments using `pyenv` and `venv`.

## Features

- Creates a Python virtual environment with a single command.
- Activates the virtual environment automatically.
- Option to specify the Python version to use.
- Option to clean up the folder by removing `.git`, `.gitignore`, local `pyenv` Python version, and `venv`.
- Easy to use and customizable.

## Installation

1. Clone the repository:

```bash
git clone https://github.com/<USERNAME>/vnv.git
```

2. Copy the `vnv` script to your `$PATH`:

```bash
cp vnv/vnv /usr/local/bin/
```

3. Make the script executable:

```bash
chmod +x /usr/local/bin/vnv
```

## Usage

```bash
Usage: vnv [OPTIONS] [PYTHON_VERSION]
  Creates and activates a Python virtual environment using the specified PYTHON_VERSION
  If no PYTHON_VERSION is specified, creates and activates a Python virtual environment using the default Python version.
Options:
  -h, --help            Show this help message and exit
  -d, --deactivate      Deactivate the current virtual environment
  -c, --clean           Clean up the folder by removing .git, .gitignore, local pyenv python version, and venv
  -p, --path            Specify the path to the folder where the virtual environment should be created
```

Examples:

```bash
# Create a virtual environment using the default Python version
vnv

# Create a virtual environment using Python 3.9.5
vnv 3.9.5

# Clean up the folder
vnv -c

# Specify the path to the folder where the virtual environment should be created
vnv -p /path/to/folder
```

## License

`vnv` is released under the [MIT License](https://github.com/<USERNAME>/vnv/blob/main/LICENSE).
