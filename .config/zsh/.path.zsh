export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.local/lib/
export PATH=$PATH:$HOME/.local/bin/

if [ -d "/opt/homebrew/bin" ]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

if [ -d "/opt/homebrew/opt/rustup/bin" ]; then
    export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
    fpath+=/opt/homebrew/opt/rustup/share/zsh/site-functions
fi

[ -d "$HOME/.cargo/bin" ] && export PATH="$PATH:$HOME/.cargo/bin"

[ -d "/opt/homebrew/opt/llvm/bin" ] && export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

