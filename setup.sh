#!/bin/bash  

export ZSH_CUSTOM="$HOME/.config/zsh"

spix  -q -t "Donwlading oh-my-zsh..."  -p "git clone https://github.com/robbyrussell/oh-my-zsh.git --depth 1 $ZSH_CUSTOM/.oh-my-zsh"
spix  -q -t "Donwlading plugins..." -p "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/.oh-my-zsh/plugins/zsh-syntax-highlighting && git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/.oh-my-zsh/plugins/zsh-autosuggestions && git clone https://github.com/marlonrichert/zsh-autocomplete $ZSH_CUSTOM/.oh-my-zsh/plugins/zsh-autocomplete && git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins $ZSH_CUSTOM/.oh-my-zsh/plugins/autoupdate"
echo "Donwlading complete"
# Copiando archivos 
configs=($(ls -A $(pwd)/files))
for _config in "${configs[@]}"; do
    spix  -t "Copiyng $_config" -p "cp -rf $(pwd)/files/$_config $HOME/.config;"
done

ln -s ~/.config/zsh/zshrc ~/.zshrc
ln -s ~/.config/zsh/zshenv ~/.zshenv

