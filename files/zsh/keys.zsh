#--------Wep------------
#https://tecnoysoft.com/2025/03/04/atajos-de-teclado-para-nuestra-shell-zsh-konsole/

unset KEYTIMEOUT 
# Line navigation and editing
bindkey "^A" beginning-of-line       # Move cursor to start of line
bindkey "^E" end-of-line             # Move cursor to end of line
bindkey "^K" kill-line               # Delete from cursor to end of line
bindkey "^U" backward-kill-line      # Delete from cursor to start of line
bindkey "^W" backward-kill-word      # Delete previous word (space delimited)
bindkey "^L" clear-screen            # Clear terminal

# Process control
bindkey "^C" send-break              # Interrupt (SIGINT) current process
bindkey "^D" delete-char-or-list     # Delete character or logout if empty
bindkey "^Z" suspend                 # Suspend (SIGTSTP) current process

# History search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search    # Up arrow
bindkey "^[[B" down-line-or-beginning-search  # Down arrow

# Word manipulation
autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey "^[m" copy-earlier-word      # Copy earlier word
bindkey "^[f" forward-word           # Move forward one word
bindkey "^[b" backward-word          # Move backward one word
bindkey "^b" backward-word           # Alternative backward word

# Clipboard operations
copy-command () { $CLIPCOPY <<< $BUFFER }
zle -N copy-command
bindkey "^y" copy-command            # Yank (copy) current line

# Custom commands
bindkey -s "^d" ' dexe^M ^M'         # Custom command
bindkey "^f" fzf-file-widget         # FZF file widget
bindkey -s "^g" ' lazygit^M ^M'      # Launch lazygit
bindkey -s "^h" ' reload^M ^M'       # Reload command
bindkey "^k" autosuggest-accept      # Accept autosuggestion
bindkey -s "^n" ' tdo -f^M ^M'       # Custom command
bindkey "^o" edit-command-line       # Edit command in editor
bindkey "^s" forward-word            # Alternative forward word
bindkey -s "^t" ' tea^M ^M'          # Custom command
bindkey "^u" undo                    # Undo last edit

# Advanced editing
bindkey "^x^e" edit-command-line     # Edit command in editor
bindkey "^x^v" vi-cmd-mode           # Switch to vi command mode
bindkey "^x^x" exchange-point-and-mark  # Exchange cursor and mark
bindkey "^[." insert-last-word       # Insert last word of previous command

# Hacker keyboard specific (optional)
bindkey "^[^C" new-session           # Ctrl+Alt+C for new session (if supported)
