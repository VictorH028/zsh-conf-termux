#
PREFIX := $(shell echo $$PREFIX)
FILE := $(PREFIX)/etc/apt/sources.list.d/demon-termux-packages.list
FILE0 :=  $(PREFIX)/etc/apt/sources.list.d/ivam3-termux-packages.list
URL := https://raw.githubusercontent.com/VictorH028/victorh028.github.io/refs/heads/main/key/demon-termux-packages.list

# Objetivo por defecto
all:  check_key install
#
check_key:
	@if [ -f $(FILE) ] || [ -f $(FILE0) ]; then \
		echo " "; \
	else \
        echo "Downloading from $(URL)..."; \
        curl -o $(FILE) $(URL); \
        echo "File  downloading."; \
		apt update > /dev/null; \
	fi
#
install:
	@echo "Running Setup..."  
	@bash setup.sh
# Limpiar (fish) 
fish:
	@echo "Borando fish"
	@rm -rf ~/.config/fish/ 
# Solo limpiat (zsh)
clear:
	@echo "Remove zsh"
	@rm -rf ~/.config/shell 
	@rm -rf ~/.config/zsh 
	@rm -rf ~/.zshrc ~/.zshenv  
