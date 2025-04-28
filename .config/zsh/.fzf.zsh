export FZF_ALT_C_OPTS="
  -i
  --walker-skip .git,node_modules,target,.idea,.vscode,.cargo
  --preview 'tree -C {}'"

if command -v fzf &> /dev/null; then
  source <(fzf --zsh 2> /dev/null)
fi

## OLD
# if [ -f /opt/homebrew/opt/fzf/bin ]; then
#   if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
#     PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
#   fi
#   
#   [[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null
#   
#   source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
# fi
# 
# 
# [ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh
# [ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
