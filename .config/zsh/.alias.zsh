alias ..='cd ..'
alias q='exit'
alias doc='cd $HOME/Documents/'
alias prj='cd $HOME/Documents/projects/'
alias mkcd='foo() { mkdir -p "$1"; cd "$1"; }; foo'
alias fileserver='dufs -A $HOME/Documents/shared'

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  alias update='sudo dnf update'
elif [[ "$OSTYPE" == "darwin"* ]]; then
  alias update='brew update && brew upgrade'
fi

alias untar='tar -xzvf'
