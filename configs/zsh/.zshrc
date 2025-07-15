############################################################
# ENVIRONMENT VARIABLES
# General environment and XDG variables
############################################################
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

export ZSH_CONFIG="$XDG_CONFIG_HOME/zsh"
export ZSH_CACHE="$XDG_CACHE_HOME/zsh"
export ZSH_COMPDUMP="$ZSH_CACHE/.zcompdump-$HOST"
export GIT_CONFIG="$XDG_CONFIG_HOME/git/config"
export DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet"
export SQLITE_HOME="$XDG_CONFIG_HOME/sqlite"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export NSS_DEFAULT_DB_DIR="$XDG_DATA_HOME/pki/nssdb"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export GPG_TTY="$(tty)"
export CARGO_HOME="$HOME/.rust/cargo"
export RUSTUP_HOME="$HOME/.rust/rustup"

############################################################
# EDITOR SETUP
# Prefer nvim if available, otherwise fallback to vim
############################################################
if (( $+commands[nvim] )); then
  export EDITOR="nvim"
else
  export EDITOR="vim"
fi

############################################################
# PATH SETUP
# Add user, Homebrew, Rust, Cargo, LLVM, and Android paths
############################################################
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/.local/lib/"
export PATH="$PATH:$HOME/.local/bin/"

# Homebrew (macOS)
if [ -d "/opt/homebrew/bin" ]; then
  export PATH="/opt/homebrew/bin:$PATH"
fi

# Rustup and Cargo
if [ -d "$RUSTUP_HOME/bin" ]; then
  export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
  fpath+=(/opt/homebrew/opt/rustup/share/zsh/site-functions)
fi
[ -d "$CARGO_HOME/bin" ] && export PATH="$PATH:$CARGO_HOME/bin"
[ -d "/opt/homebrew/opt/llvm/bin" ] && export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

############################################################
# FZF INTEGRATION
# Fuzzy finder configuration and keybindings
############################################################
export FZF_ALT_C_OPTS="
  -i
  --walker-skip .git,node_modules,target,.idea,.vscode,.cargo
  --preview 'tree -C {}'"

if command -v fzf &> /dev/null; then
  source <(fzf --zsh 2> /dev/null)
fi

############################################################
# HISTORY SETTINGS
# Configure Zsh history behavior and file locations
############################################################
if [[ ! -d "$ZSH_CACHE" ]]; then
  mkdir -p "$ZSH_CACHE"
fi

HISTFILE="$ZSH_CACHE/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt SHARE_HISTORY        # Share history across sessions
setopt INC_APPEND_HISTORY   # Incrementally append to history
setopt EXTENDED_HISTORY     # Extended history format
setopt HIST_IGNORE_ALL_DUPS # Ignore duplicate commands
setopt HIST_FIND_NO_DUPS    # Don't show dups in search
setopt HIST_REDUCE_BLANKS   # Remove superfluous blanks

############################################################
# PROMPT SETUP
# Custom prompt with git branch and status
############################################################
parse_git_branch() {
  local branch=""
  branch=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  local git_status=$(git status --porcelain 2>/dev/null)
  local color=green

  if echo "$git_status" | grep -q "^ M"; then
    color=yellow
    branch="${branch}*"
  fi
  if echo "$git_status" | grep -qE "^ A|^\?\?"; then
    color=yellow
    branch="${branch}+"
  fi
  if echo "$git_status" | grep -q "^ D"; then
    color=yellow
    branch="${branch}-"
  fi

  if [[ -n "$branch" ]]; then
    branch="[%F{${color}}${branch}%F{reset}]"
    echo "$branch "
  fi
}

update_prompt() {
  PROMPT="$USER@$HOST %1~ $(parse_git_branch)# "
}
precmd_functions+=(update_prompt)
update_prompt

############################################################
# COMPLETION SETTINGS
# Zsh completion system and matcher
############################################################
autoload -Uz compinit
compinit -d "$ZSH_COMPDUMP"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

############################################################
# ALIASES & FUNCTIONS
# Common aliases and helper functions
############################################################
# Navigation
alias ..='cd ..'
alias q='exit'
alias doc='cd $HOME/Documents/'
alias prj='cd $HOME/Documents/projects/'
alias mkcd='foo() { mkdir -p "$1"; cd "$1"; }; foo'
alias fileserver='dufs -A $HOME/Documents/shared'
alias untar='tar -xzvf'

# OS-specific update alias
detect_distro() {
  local name="Unknown"
  local version="Unknown"
  if [[ -f /etc/os-release ]]; then
    while IFS='=' read -r key value; do
      value="${value%\"}"
      value="${value#\"}"
      case "$key" in
        NAME) name="$value" ;;
        VERSION_ID) version="$value" ;;
      esac
    done < /etc/os-release
  fi
  echo "$name"
}

case "$OSTYPE" in
  linux-gnu*)
    DISTRO_NAME=$(detect_distro)
    case "$DISTRO_NAME" in
      "Arch Linux"*) alias update='$ZSH_CONFIG/.arch-update.sh' ;;
      "Fedora")      alias update='sudo dnf update' ;;
    esac
    ;;
  darwin*)
    alias update='brew update && brew upgrade'
    ;;
esac

# Add path helper
addpath() {
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
  echo "$path_line" >> "$path_file"
  echo "Added to $path_file: $path_line"
  source "$path_file"
}

############################################################
# PLUGIN INITIALIZATION
# Enable syntax highlighting and autosuggestions
############################################################
source "$ZSH_CONFIG/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$ZSH_CONFIG/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
