
#! /bin/bash
help () {
  echo "Usage: vnv [OPTIONS] [PYTHON_VERSION]"
  echo "  Creates and activates a Python virtual environment using the specified PYTHON_VERSION"
  echo "  If no PYTHON_VERSION is specified, creates and activates a Python virtual environment using the default Python version."
  echo "Options:"
  echo "  -h, --help            Show this help message and exit"
  echo "  -d, --deactivate      Deactivate the current virtual environment"
  echo "  -c, --clean           Clean up the folder by removing .git, .gitignore, local pyenv python version, and venv"
  echo "  -p, --path            Specify the path to the folder where the virtual environment should be created"
}




vnv () {
  # Check if pyenv and git are installed
  if ! command -v pyenv &> /dev/null; then
    echo "pyenv not found. Please install pyenv and try again."
    return 1
  fi
  
  if ! command -v git &> /dev/null; then
    echo "git not found. Please install git and try again."
    return 1
  fi

  local deactivate=false
  local clean=false
  local venv_name="$(basename "$(pwd)")-venv"
  local venv_path="$(pwd)"

  while [[ $# -gt 0 ]]; do
    case $1 in
      -h|--help)
        help
        return
        ;;
      -d|--deactivate) 
        deactivate=true
        shift
        ;;
      -c|--clean)
        clean=true
        shift
        ;;
      -p|--path)
      # extract the last dir in path ex: /home/dovid/Projects/Python/venv-test -> venv-test
        venv_name="$(basename "$2")-venv"
        venv_path="$2"
        shift 2
        ;;
      *)
        break
        ;;
    esac
  done


  if [ "$deactivate" = true ]; then
    deactivate
    return
  fi



  if [ "$clean" = true ]; then
    # accept input from the user to confirm if they want to clean up the folder

  if [ -n "$ZSH_VERSION" ]; then
  read "response?Are you sure you want to clean up the folder? (y/n) "
  else
  read -p "Are you sure you want to clean up the folder? (y/n) " -r response
  fi

if [[ ! $response =~ ^[Yy]$ ]]; then
  return
fi

    # read -p "Are you sure you want to clean up the folder? (y/n) " -n 1 -r
    # echo ""
    # if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    #   return
    # fi
    echo "Cleaning up the folder..."
    (cd "$venv_path" && rm -rf .git .gitignore "$venv_name" && pyenv local --unset)
    deactivate 2> /dev/null
    return
  fi

  # Check if a virtual environment already exists
  if [ -d "$venv_path/$venv_name" ]; then
    echo "Activating existing virtual environment... $venv_name"
    source "$venv_path/$venv_name/bin/activate"
    return
  fi

  # Set the local python version
  if [ -n "$1" ]; then
    python_version="$1"
    if ! pyenv versions | grep -qF "$python_version"; then
      echo "Installing Python $python_version..."
      if ! pyenv install "$python_version"; then
        return 1
      fi
    fi
    echo "Setting local python version to $python_version..."
    (cd "$venv_path" && pyenv local "$python_version")
  fi

  
  # Create the virtual environment
  echo "Creating virtual environment $venv_name in $venv_path..."
  python3 -m venv "$venv_path/$venv_name"

  # Activate the virtual environment
  source "$venv_path/$venv_name/bin/activate"

  # Set up git and .gitignore
  echo "Initializing git..."
  echo "Setting up .gitignore..."
  (cd "$venv_path" && git init > /dev/null && template_path="/home/dovid/bin/templates/.gitignore" && cp "$template_path" . && git add . > /dev/null && git commit -m "Initial commit with .gitignore" > /dev/null && python -m pip install --upgrade pip > /dev/null)
}

# help () {
#   echo "Usage: vnv [OPTIONS] [PYTHON_VERSION]"
#   echo "  Creates and activates a Python virtual environment using the specified PYTHON_VERSION"
#   echo "  If no PYTHON_VERSION is specified, creates and activates a Python virtual environment using the default Python version."
#   echo "Options:"
#   echo "  -h, --help            Show this help message and exit"
#   echo "  -d, --deactivate      Deactivate the current virtual environment"
#   echo "  -c, --clean           Clean up the folder by removing .git, .gitignore, local pyenv python version, and venv"
#   echo "  -p, --path            Specify the path to the folder where the virtual environment should be created"
# }

# check_dependencies () {
#   for cmd in pyenv git; do
#     if ! command -v "$cmd" &> /dev/null; then
#       echo "$cmd not found. Please install $cmd and try again."
#       return 1
#     fi
#   done
#   return 0
# }

# parse_arguments () {
#   local -n deactivate_ref=$1
#   local -n clean_ref=$2
#   local -n path_ref=$3
#   local -n python_version_ref=$4

#   local OPTIND opt
#   while getopts "hdcp:" opt; do
#     case $opt in
#       h)
#         help
#         return 1
#         ;;
#       d)
#         deactivate_ref=true
#         ;;
#       c)
#         clean_ref=true
#         ;;
#       p)
#         path_ref="$OPTARG"
#         ;;
#       *)
#         return 1
#         ;;
#     esac
#   done

#   shift $((OPTIND - 1))
#   if [ $# -gt 0 ]; then
#     python_version_ref="$1"
#   fi
# }

# confirm_cleanup () {
#   if [ -n "$ZSH_VERSION" ]; then
#     read "response?Are you sure you want to clean up the folder? (y/n) "
#   else
#     read -p "Are you sure you want to clean up the folder? (y/n) " -r response
#   fi

#   [[ $response =~ ^[Yy]$ ]]
# }

# deactivate_venv () {
#   deactivate 2> /dev/null
# }

# clean_up_folder () {
#   local venv_path="$1"
#   local venv_name="$2"

#   echo "Cleaning up the folder..."
#   (cd "$venv_path" && rm -rf .git .gitignore "$venv_name" && pyenv local --unset)
#   deactivate_venv
# }

# set_python_version () {
#   local venv_path="$1"
#   local python_version="$2"

#   if ! pyenv versions | grep -qF "$python_version"; then
#     echo "Installing Python $python_version..."
#     if ! pyenv install "$python_version"; then
#       return 1
#     fi
#   fi
#   echo "Setting local python version to $python_version..."
#   (cd "$venv_path" && pyenv local "$python_version")
# }

# create_venv () {
#   local venv_path="$1"
#   local venv_name="$2"

#   echo "Creating virtual environment $venv_name in $venv_path..."
#   python3 -m venv "$venv_path/$venv_name"
#   source "$venv_path/$venv_name/bin/activate"
# }

# initialize_git () {
#   local venv_path="$1"

#   echo "Initializing git..."
#   echo "Setting up .gitignore..."
#   (cd "$venv_path" && git init > /dev/null && template_path="/home/dovid/bin/templates/.gitignore" && cp "$template_path" . && git add . > /dev/null && git commit -m "Initial commit with .gitignore" > /dev/null && python -m pip install --upgrade pip > /dev/null)
# }

# vnv () {
#   if ! check_dependencies; then
#     return 1
#   fi

#   local deactivate=false
#   local clean=false
#   local venv_path="$(pwd)"
#   local python_version=""
#   parse_arguments deactivate clean venv_path python_version "$@"

#   if [ "$deactivate" = true ]; then
#     deactivate_venv
#     return
#   fi

#   local venv_name="$(basename "$venv_path")-venv"

#   if [ "$clean" = true ]; then
#     if confirm_cleanup; then
#       clean_up_folder "$venv_path" "$venv_name"
#     fi
#     return
#   fi

#   if [ -n "$python_version" ]; then
#     if ! set_python_version "$venv_path" "$python_version"; then
#       return 1
#     fi
#   fi

#   if [ -d "$venv_path/$venv_name" ]; then
#     echo "Activating existing virtual environment... $venv_name"
#     source "$venv_path/$venv_name/bin/activate"
#     return
#   fi

#   create_venv "$venv_path" "$venv_name"
#   initialize_git "$venv_path"
# }
