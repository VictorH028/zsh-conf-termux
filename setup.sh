#!/bin/bash  

#
export ZSH_CUSTOM="$HOME/.config/zsh"

URL_SHELL=("https://github.com/robbyrussell/oh-my-zsh.git" \
    "https://github.com/zsh-users/zsh-syntax-highlighting.git" \
    "https://github.com/zsh-users/zsh-autosuggestions" \
    "https://github.com/marlonrichert/zsh-autocomplete")
# Ojo con las rutas 
PATH_URL=("$ZSH_CUSTOM/.oh-my-zsh" \
   "$ZSH_CUSTOM/.oh-my-zsh/plugins/zsh-syntax-highlighting" \
   "$ZSH_CUSTOM/.oh-my-zsh/plugins/zsh-autosuggestions" \
    " $ZSH_CUSTOM/.oh-my-zsh/plugins/autoupdate")

count=0
for u in ${URL_SHELL[@]}; do
    spin -q -t "Donwlading  $u" -p "git clone --depth 1  $u \
        ${PATH_URL[$((count++))]}" -c 115
done
echo -en "\rDonwlading complete"

# Copiando archivos 
configs=($(ls -A $(pwd)/files))
for _config in "${configs[@]}"; do
    spin  -t "Copiyng $_config" -p "cp -rf $(pwd)/files/$_config $HOME/.config;" -c 115
done

# 
if test -d ~/.config/zsh; then
    # Comprobar si ~/.zshrc ya existe
    if test -f ~/.zshrc; then
        echo "El archivo ~/.zshrc ya existe."
    else
        ln -s ~/.config/zsh/zshrc ~/.zshrc
        echo "Enlace simbólico creado para ~/.zshrc."
    fi

    # Comprobar si ~/.zshenv ya existe
    if test -f ~/.zshenv; then
        echo "El archivo ~/.zshenv ya existe."
    else
        ln -s ~/.config/zsh/zshenv ~/.zshenv
        echo "Enlace simbólico creado para ~/.zshenv."
    fi
else
    echo "El directorio ~/.config/zsh no existe."
fi
