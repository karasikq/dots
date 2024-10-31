export ZSH_CONFIG="$HOME/.config/zsh"
export ZSH_CACHE="$HOME/.cache/zsh/"
export EDITOR="nvim"
export ZSH_COMPDUMP=$ZSH_CACHE/.zcompdump-$HOST

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

autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

source $ZSH_CONFIG/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_CONFIG/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
