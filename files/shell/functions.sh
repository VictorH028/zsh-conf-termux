#!/bin/bash
# Functions

# 
background() {
  for ((i=2;i<=$#;i++)); do 
    ${@[1]} ${@[$i]} &> /dev/null &
  done
}


# copy authy token
auth() {
    mambembe-cli get-token -s "$@" | fzf --reverse -0 -1 | rg -oP 'Token: "\K\d+' | $CLIPCOPY
}

# cd into dir and list contents
lc() {
    cd "$1" && la "$2"
}

# Make directory and cd into it
mcd() {
    mkdir -p -- "$1" && cd -P -- "$1"
}

# kill all tmux sessions
tmux-clean() {
    tmux list-sessions | grep -E -v '\(attached\)$' | while IFS='\n' read line; do
        tmux kill-session -t "${line%%:*}"
    done
}

# Execute command in directory
xin() {
    (cd "${1}" && shift && ${@})
}

# edit a binary file in path, useful for editing executables/symlinked scripts
bine() {
    local bin=""
    bin=$(which "$1")
    if [ -z "$bin" ]; then
        echo "Binary not found in path"
        return 1
    fi
    $EDITOR "$bin"
}

# ex - archive extractor
ex() {
    if [ -f "$1" ]; then
        case $1 in
        *.tar.bz2) tar xjf "$1" ;;
        *.tar.gz) tar xzf "$1" ;;
        *.bz2) bunzip2 "$1" ;;
        *.rar) unrar x "$1" ;;
        *.gz) gunzip "$1" ;;
        *.tar) tar xf "$1" ;;
        *.tbz2) tar xjf "$1" ;;
        *.tgz) tar xzf "$1" ;;
        *.zip) unzip "$1" ;;
        *.Z) uncompress "$1" ;;
        *.7z) 7z x "$1" ;;
        *) echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}


# colorized man output
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;36m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        PAGER="${commands[less]:-$PAGER}" \
        _NROFF_U=1 \
        PATH="$HOME/bin:$PATH" \
        man "$@"
}

# show colored text
color_text() {
    for code in {000..255}; do
        printf "%s: \033[38;5;%smThis is how your text would look like\033[0m\n" "$code" "$code"
    done
}

# 
baner_pantalla() {
  bash "~/.local/etc/i-Haklab/banner/i-Haklab"
}

adminfiles() {
  am start -a android.intent.action.VIEW -d "content://com.android.externalstorage.documents/root/primary" >/dev/null
}

cinderella() {
        if [ test ls /data/data/com.termux/files/home/.local/libexec/cinderella 2>/dev/null ]; then           
            bash /data/data/com.termux/files/home/.local/libexec/cinderella $argv           
        else
           echo -en "\e[31m(➤_)\e[0m missing argument, type i-Haklab help for helpper\n"
        fi 
}
