export ZSH_CONFIG="$HOME/.config/zsh"
source "$ZSH_CONFIG/.env.zsh"
source "$ZSH_CONFIG/.prompt.zsh"
source "$ZSH_CONFIG/.fzf.zsh"
source "$ZSH_CONFIG/.android.zsh"
source "$ZSH_CONFIG/.path.zsh"
source "$ZSH_CONFIG/.alias.zsh"

HISTSIZE=1000
HISTFILE=$ZSH_CACHE/.zsh_history
SAVEHIST=1000
HISTDUP=erase
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS

autoload -Uz compinit
compinit -d "$ZSH_COMPDUMP"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

source $ZSH_CONFIG/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_CONFIG/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
