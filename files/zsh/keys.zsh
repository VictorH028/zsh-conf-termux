# ============================================================
# KEYBINDINGS - Configuración optimizada y sin conflictos
# ============================================================

unset KEYTIMEOUT

# ===== NAVEGACIÓN BÁSICA =====
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line                  # Borrar hasta el final
bindkey "^U" backward-kill-line         # Borrar hasta el inicio
bindkey "^W" backward-kill-word         # Borrar palabra anterior
bindkey "^L" clear-screen

# ===== CONTROL DE PROCESOS =====
bindkey "^C" send-break
bindkey "^D" delete-char-or-list
bindkey "^Z" suspend

# ===== HISTORIAL INTELIGENTE =====
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# ===== MOVIMIENTO POR PALABRAS =====
bindkey "^[f" forward-word              # Alt+F
bindkey "^[b" backward-word             # Alt+B
bindkey "^[d" delete-word               # Alt+D - Borrar palabra

# ===== DESHACER/REHACER =====
bindkey "^_" undo                       # Ctrl+/ - Deshacer
bindkey "^X^U" undo                     # Ctrl+X Ctrl+U - Alternativa
bindkey "^X^R" redo                     # Ctrl+X Ctrl+R - Rehacer

# ===== HISTORIAL Y BÚSQUEDA =====
bindkey "^R" history-incremental-search-backward  # Ctrl+R - Buscar en historial
bindkey "^S" history-incremental-search-forward   # Ctrl+S (requiere stty -ixon)

# ===== PORTAVIPAPELES (clipboard) =====
copy-command () {
    if [[ -n $BUFFER ]]; then
        echo -n "$BUFFER" | ${CLIPCOPY <<< $BUFFER }
        echo "✅ Copiado: $BUFFER"
    fi
}
zle -N copy-command
bindkey "^Y" copy-command              # Ctrl+Y - Copiar línea

paste-clipboard () {
    LBUFFER+=$(xclip -selection clipboard -o 2>/dev/null || wl-paste 2>/dev/null)
}
zle -N paste-clipboard
bindkey "^V" paste-clipboard           # Ctrl+V - Pegar

# ===== EDITOR DE LÍNEA =====
bindkey "^O" edit-command-line         # Ctrl+O - Editar en editor
bindkey "^X^E" edit-command-line       # Ctrl+X Ctrl+E - Alternativa
bindkey "^X^V" vi-cmd-mode             # Ctrl+X Ctrl+V - Modo Vi
bindkey "^[." insert-last-word         # Alt+. - Última palabra

# ===== COMANDOS RÁPIDOS ÚTILES =====
bindkey -s "^G" 'lazygit\n'            # Ctrl+G - Git TUI
bindkey -s "^H" 'htop\n'               # Ctrl+H - Monitor de procesos
bindkey -s "^N" 'nvim .\n'             # Ctrl+N - Neovim en directorio actual
bindkey -s "^T" 'tree -L 2\n'          # Ctrl+T - Árbol de directorios
bindkey -s "^P" 'python3\n'            # Ctrl+P - Python REPL
bindkey -s "^F" 'fzf\n'                # Ctrl+F - Buscador FZF

# ===== AUTOCOMPLETADO =====
bindkey "^I" expand-or-complete        # Tab - Autocompletar
bindkey "^[[Z" reverse-menu-complete   # Shift+Tab - Retroceder en menú

# ===== SUGERENCIAS (si usás zsh-autosuggestions) =====
if command -v zsh-autosuggestions >/dev/null 2>&1; then
    bindkey "^K" autosuggest-accept    # Ctrl+K - Aceptar sugerencia
    bindkey "^[ " autosuggest-execute  # Alt+Espacio - Ejecutar sugerencia
fi

# ===== FUNCIONES ÚTILES =====
# Buscar en el historial con filtro
bindkey "^[r" history-beginning-search-backward  # Alt+R - Buscar desde inicio

# Completar nombre de archivo
bindkey "^X^F" complete-files          # Ctrl+X Ctrl+F - Completar archivos

# ===== ATEJOS PARA LA VIDA DIARIA =====
# Ctrl+Alt+C - Crear nueva terminal (si usás kitty, alacritty, etc)
if [[ $TERM == xterm* ]] || [[ $TERM == screen* ]] || [[ $TERM == tmux* ]]; then
    bindkey "^[^C" new-session         # Alt+Ctrl+C - Nueva terminal
fi

# Limpiar y mostrar mensaje
clear-and-status () {
    clear
    echo "🚀 Terminal lista - $(date '+%H:%M:%S')"
}
zle -N clear-and-status
bindkey "^L" clear-and-status          # Ctrl+L - Limpiar con mensaje

# ============================================================
# FIN DE CONFIGURACIÓN
# ============================================================
