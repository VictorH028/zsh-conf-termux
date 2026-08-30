#!/bin/bash  

#
export CONFIG_PATH="$HOME/.config/zsh"

URL_SHELL=("https://github.com/robbyrussell/oh-my-zsh.git" \
    "https://github.com/zsh-users/zsh-syntax-highlighting.git" \
    "https://github.com/zsh-users/zsh-autosuggestions.git" \
    "https://github.com/marlonrichert/zsh-autocomplete.git" )
    # "https://github.com/romkatv/powerlevel10k.git")

# Ojo con las rutas 
PATH_URL=(
   "$CONFIG_PATH/.oh-my-zsh" \
   "$CONFIG_PATH/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" \
   "$CONFIG_PATH/.oh-my-zsh/custom/plugins/zsh-autosuggestions" \
   "$CONFIG_PATH/.oh-my-zsh/custom/plugins/zsh-autocomplete" )
   # "$CONFIG_PATH/.oh-my-zsh/custom/themes/powerlevel10k" )

count=0
for u in ${URL_SHELL[@]}; do
    spin -q -t "Donwlading...  $u" --cmd "git clone --depth 1  $u \
        ${PATH_URL[$((count++))]}" -c 115 --result --success "Donwlading complete..."
done


# Copiar los  archivos 
configs=($(ls -A $(pwd)/files))
for _config in "${configs[@]}"; do
    spin  -t "Copiyng $_config" --cmd "cp -rf $(pwd)/files/$_config $HOME/.config  && sleep 1" -c 115 -q
done

# 
if test -d ~/.config/zsh; then
    if test -f ~/.zshrc; then
        echo "El archivo ~/.zshrc ya existe."
    else
        ln -s ~/.config/zsh/zshrc ~/.zshrc
        # echo "Enlace simbólico creado para ~/.zshrc."
    fi

    if test -f ~/.zshenv; then
        echo  "El archivo ~/.zshenv ya existe."
    else
        ln -s ~/.config/zsh/zshenv ~/.zshenv 
        # echo "Enlace simbólico creado para ~/.zshenv."
    fi
else
    echo "El directorio ~/.config/zsh no existe."
fi 

wget https://raw.githubusercontent.com/VictorH028/zsh-conf-termux/refs/heads/main/theme/haklab.zsh-theme -qP $HOME/.config/zsh/.oh-my-zsh/custom/themes
