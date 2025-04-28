alias ..='cd ..'
alias q='exit'
alias doc='cd $HOME/Documents/'
alias prj='cd $HOME/Documents/projects/'
alias mkcd='foo() { mkdir -p "$1"; cd "$1"; }; foo'
alias fileserver='dufs -A $HOME/Documents/shared'

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	DISTRO_NAME="Unknown"
	DISTRO_VERSION="Unknown"
	
	if [[ -f /etc/os-release ]]; then
	  while IFS='=' read -r key value; do
	    value=$(sed 's/^"//' <<< "$value")
	    value=$(sed 's/"$//' <<< "$value")
	    case "$key" in
	      NAME)
	        DISTRO_NAME="$value"
	        ;;
	      VERSION_ID)
	        DISTRO_VERSION="$value"
	        ;;
	    esac
	  done < /etc/os-release
	fi

	if [[ "$DISTRO_NAME" == "Arch Linux"* ]]; then
  		alias update='$ZSH_CONFIG/.arch-update.sh'
	elif [[ "$DISTRO_NAME" == "Fedora" ]]; then
  		alias update='sudo dnf update'
	fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
  alias update='brew update && brew upgrade'
fi

alias untar='tar -xzvf'

function addpath() {
  if [[ -z "$1" ]]; then
    echo "Usage: addpath /path/to/add" >&2
    return 1
  fi

  local path_to_add="$1"
  local path_file="$ZSH_CONFIG/.path.zsh"

  if [[ ":$PATH:" == *":$path_to_add:"* ]]; then
    echo "Path already exists in \$PATH: $path_to_add" >&2
    return 2
  fi

  local path_line="[ -d \"$path_to_add\" ] && export PATH=\"\$PATH:$path_to_add\""

  echo $path_line >> "$path_file"
  echo "Added to $path_file: $path_line"

  source "$path_file"
}
