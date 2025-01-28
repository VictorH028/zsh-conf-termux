#
PREFIX := $(shell echo $$PREFIX)
FILE := $(PREFIX)/etc/apt/sources.list.d/demon-termux-packages.list
URL := https://raw.githubusercontent.com/VictorH028/victorh028.github.io/refs/heads/main/key/demon-termux-packages.list

# Objetivo por defecto
all:  check_key install


#
check_key:
	@if [ -f $(FILE) ]; then \
		echo " "; \
	else \
        echo "Downloading from $(URL)..."; \
        curl -o $(FILE) $(URL); \
        echo "File  downloading."; \
		apt update > /dev/null; \
	fi

install:
	@echo "Running Setup..."  
	@bash setup.sh

clear:
	@echo "Remove zsh"
	@rm -rf ~/.config/shell 
	@rm -rf ~/.config/zsh 
	@rm -rf ~/.zshrc ~/.zshenv  
