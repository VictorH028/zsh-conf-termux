# Este archivo se obtiene únicamente para shells interactivos.  Él
# debe contener comandos para configurar alias, funciones,
# opciones, combinaciones de teclas, etc.
#
# orden Gloval : zshenv, zprofile, zshrc, zlogin    

# i-Haklab Zsh Configuration
# Mirrored from .local/etc/fish/config.fish

# Command not found handler
command_not_found_handler() {
    /data/data/com.termux/files/usr/libexec/termux/command-not-found "$1"
}

# Login session (runs i-Haklab login script)
if [[ -o login ]]; then
    bash /data/data/com.termux/files/home/.local/libexec/i-Haklab.login
fi

# Environment Variables
source /data/data/com.termux/files/home/.local/etc/i-Haklab/envvariables
#................................................

# Load configs in specific order
source "$ZDOTDIR/omz.zsh"
source "$ZDOTDIR/options.zsh"
source ~/.config/shell/functions.sh
source ~/.config/shell/config.sh
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/keys.zsh"


