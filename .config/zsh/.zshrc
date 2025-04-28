export ZSH_CONFIG="$HOME/.config/zsh"
source "$ZSH_CONFIG/.path.zsh"
source "$ZSH_CONFIG/.env.zsh"
source "$ZSH_CONFIG/.prompt.zsh"
source "$ZSH_CONFIG/.fzf.zsh"
source "$ZSH_CONFIG/.android.zsh"
source "$ZSH_CONFIG/.alias.zsh"

if [[ ! -d "$ZSH_CACHE" ]]; then
    mkdir -p "$ZSH_CACHE"
fi
HISTFILE=$ZSH_CACHE/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY       
setopt INC_APPEND_HISTORY  
setopt EXTENDED_HISTORY    
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

autoload -Uz compinit
compinit -d "$ZSH_COMPDUMP"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

source $ZSH_CONFIG/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_CONFIG/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
