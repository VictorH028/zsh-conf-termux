# ============================================
# CONFIGURACIÓN DE COLORES PERSONALIZADOS
# ============================================
# spin --show_colors  
# ---- COLORES DE TEXTO ----
local FACE_GOOD="%F{46}"        # Verde brillante
local FACE_BAD="%F{196}"        # Rojo brillante
local DIR_TEXT="%F{15}"         # Blanco
local CONTEXT_TEXT="%F{15}"     # Blanco
local BRANCH_TEXT="%F{15}"      # Blanco
local GIT_CLEAN_TEXT="%F{15}"   # Blanco
local GIT_DIRTY_TEXT="%F{16}"   # Negro
local JOB_TEXT="%F{51}"         # Cian
local ERROR_TEXT="%F{196}"      # Rojo brillante
local SYMBOL_TEXT="%F{201}"     # Magenta brillante

# ---- COLORES DE FONDO ----
local FACE_BG="%K{16}"          # Negro
local DIR_BG="%K{25}"           # Azul
local CONTEXT_BG="%K{16}"       # Negro
local GIT_CLEAN_BG="%K{40}"     # Verde
local GIT_DIRTY_BG="%K{226}"    # Amarillo
local STATUS_BG="%K{16}"        

# haklab-simple-fixed.zsh-theme
# Versión simple y corregida

CURRENT_BG='NONE'
SEGMENT_SEPARATOR=$'\ue0b0'

prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

prompt_end() {
  if [[ -n $CURRENT_BG && $CURRENT_BG != 'NONE' ]]; then
    echo -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  fi
  echo -n "%{%k%f%}"
  CURRENT_BG='NONE'
}

# Carita - segmento con fondo negro
prompt_face() {
  if [[ $RETVAL -eq 0 ]]; then
    prompt_segment "black" "green" "(-_-)"
  else
    prompt_segment "black" "red" "(x_x)"
  fi
}

# Directorio
prompt_dir() {
  prompt_segment "25" "black" "%c"
}

# Git
prompt_git() {
  (( $+commands[git] )) || return
  if [[ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" != "true" ]]; then
    return
  fi
  
  local ref dirty
  ref=$(git symbolic-ref HEAD 2>/dev/null) || ref=$(git rev-parse --short HEAD 2>/dev/null)
  ref=${ref#refs/heads/}
  dirty=$(git status --porcelain 2>/dev/null)
  
  if [[ -n "$dirty" ]]; then
    prompt_segment "yellow" "black" "${ref} ±"
  else
    prompt_segment "45" "black" "${ref} ✓"
  fi
}

build_prompt() {
  RETVAL=$?
  prompt_face
  prompt_dir
  prompt_git
  prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt) %F{magenta}%f '
