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
