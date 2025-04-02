export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export ZSH_CACHE="$HOME/.cache/zsh"
export ZSH_COMPDUMP=$ZSH_CACHE/.zcompdump-$HOST
export GIT_CONFIG="$HOME/.config/git/config"
export DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet"
export SQLITE_HOME="$XDG_CONFIG_HOME/sqlite"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export VSCODE_PORTABLE="$XDG_DATA_HOME/vscode"
export NSS_DEFAULT_DB_DIR="$XDG_DATA_HOME/pki/nssdb"
export GNUPGHOME="$HOME/.config/gnupg"
export GPG_TTY=$(tty)

if (( $+commands[nvim] )); then
  export EDITOR=nvim
else
  export EDITOR=vim
fi
