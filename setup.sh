#!/bin/bash  

#
export ZSH_CUSTOM="$HOME/.config/zsh"

# URL 
URL_OM_MY_ZSH="https://github.com/robbyrussell/oh-my-zsh.git"
URL_PLUGINS_1="https://github.com/zsh-users/zsh-syntax-highlighting.git"
URL_PLUGINS_2="https://github.com/zsh-users/zsh-autosuggestions"
URL_PLUGINS_3="https://github.com/marlonrichert/zsh-autocomplete"

# Install config  
spix  -q -t "Donwlading oh-my-zsh..."  -p "git clone $URL_OM_MY_ZSH  --depth 1 $ZSH_CUSTOM/.oh-my-zsh"
spix  -q -t "Donwlading zsh-syntax-highlighting ..." -p "git clone $URL_PLUGINS_1 $ZSH_CUSTOM/.oh-my-zsh/plugins/zsh-syntax-highlighting" 
spix  -q -t "Donwlading zsh-autosuggestions ... " -p "git clone $URL_PLUGINS_2 $ZSH_CUSTOM/.oh-my-zsh/plugins/zsh-autosuggestions " 
spix  -q -t "Donwlading zsh-autocomplete ... " -p "git clone $URL_PLUGINS_3 $ZSH_CUSTOM/.oh-my-zsh/plugins/zsh-autocomplete" 
spix  -q -t "Donwlading autoupdate-oh-my-zsh-plugins" -p   "git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins $ZSH_CUSTOM/.oh-my-zsh/plugins/autoupdate"

echo -en "\rDonwlading complete"

# Copiando archivos 
configs=($(ls -A $(pwd)/files))
for _config in "${configs[@]}"; do
    spix  -t "Copiyng $_config" -p "cp -rf $(pwd)/files/$_config $HOME/.config;"
done

#
if test -d ~/.config/zsh; then
    ln -s ~/.config/zsh/zshrc ~/.zshrc
    ln -s ~/.config/zsh/zshenv ~/.zshenv
fi

