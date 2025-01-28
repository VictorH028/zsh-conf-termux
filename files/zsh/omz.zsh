# Path to oh-my-zsh installation.
export ZSH="$ZDOTDIR/.oh-my-zsh"

# Plugins  
plugins=(
   autoupdate 
   # zsh-autocomplete 
   zsh-autosuggestions 
   zsh-syntax-highlighting
)

# Theme  
ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh
