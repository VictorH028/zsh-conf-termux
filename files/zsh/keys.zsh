autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
autoload -Uz copy-earlier-word
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N copy-earlier-word

copy-command () { $CLIPCOPY -n <<< $BUFFER }
zle -N copy-command



bindkey "^[." insert-last-word
bindkey "^[m" copy-earlier-word
bindkey "^[f" forward-word
bindkey "^[b" backward-word
bindkey "^b" backward-word
bindkey -s "^d" ' dexe^M ^M'
bindkey "^f" fzf-file-widget
bindkey -s "^g" ' lazygit^M ^M'
bindkey -s "^h" ' reload^M ^M'
bindkey "^k" autosuggest-accept
bindkey -s "^n" ' tdo -f^M ^M'
bindkey "^o" edit-command-line
bindkey "^s" forward-word
bindkey -s "^t" ' tea^M ^M'
bindkey "^u" undo
bindkey "^x^e" edit-command-line
bindkey "^x^v" vi-cmd-mode
bindkey "^x^x" exchange-point-and-mark
bindkey "^y" copy-command


