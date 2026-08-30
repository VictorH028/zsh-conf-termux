# haklab.zsh-theme 
# ============================================================
# 🚀 HakLab Theme - Professional ZSH Prompt
# ============================================================
# Características:
#   ✓ Git status con iconos
#   ✓ Tiempo de ejecución de comandos
#   ✓ Estado de salida con color
#   ✓ Path inteligente
#   ✓ Múltiples segmentos de información
# ============================================================

# ------------------------------------------------------------------
# 1. COLORS & ICONS
# ------------------------------------------------------------------
autoload -Uz colors && colors

# Colores
local fg_black="%F{black}"
local fg_red="%F{red}"
local fg_green="%F{green}"
local fg_yellow="%F{yellow}"
local fg_blue="%F{blue}"
local fg_magenta="%F{magenta}"
local fg_cyan="%F{cyan}"
local fg_white="%F{white}"
local fg_gray="%F{240}"

local bg_black="%K{black}"
local bg_red="%K{red}"
local bg_green="%K{green}"
local bg_yellow="%K{yellow}"
local bg_blue="%K{blue}"
local bg_magenta="%K{magenta}"
local bg_cyan="%K{cyan}"
local bg_white="%K{white}"

local reset_color="%f%k"

# Iconos (usa Nerd Fonts para mejor visualización)
local icon_git=""
local icon_github=""
local icon_branch=""
local icon_commit=""
local icon_dirty=""
local icon_staged=""
local icon_untracked=""
local icon_time=""
local icon_folder=""
local icon_root=""
local icon_user=""
local icon_success="✔"
local icon_fail="✘"
local icon_jobs=""
local icon_python=""
local icon_node=""
local icon_rust=""
local icon_golang=""

# ------------------------------------------------------------------
# 2. GIT FUNCTIONS
# ------------------------------------------------------------------
git_branch() {
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    if [[ -n "$branch" ]]; then
        echo "$icon_branch $branch"
    else
        local commit=$(git rev-parse --short HEAD 2>/dev/null)
        [[ -n "$commit" ]] && echo "$icon_commit $commit"
    fi
}

git_status() {
    local status=$(git status --porcelain 2>/dev/null)
    if [[ -n "$status" ]]; then
        local added=$(echo "$status" | grep -c "^A" 2>/dev/null)
        local modified=$(echo "$status" | grep -c "^ M" 2>/dev/null)
        local deleted=$(echo "$status" | grep -c "^ D" 2>/dev/null)
        local untracked=$(echo "$status" | grep -c "^??" 2>/dev/null)
        
        local output=""
        [[ $added -gt 0 ]] && output+=" %F{green}+$added%f"
        [[ $modified -gt 0 ]] && output+=" %F{yellow}~$modified%f"
        [[ $deleted -gt 0 ]] && output+=" %F{red}-$deleted%f"
        [[ $untracked -gt 0 ]] && output+=" %F{cyan}?$untracked%f"
        echo "$output"
    fi
}

# ------------------------------------------------------------------
# 3. ENVIRONMENT INFO
# ------------------------------------------------------------------
python_version() {
    if command -v python >/dev/null 2>&1; then
        local version=$(python --version 2>&1 | cut -d' ' -f2 | cut -d. -f1-2)
        echo "$icon_python $version"
    fi
}

node_version() {
    if command -v node >/dev/null 2>&1; then
        local version=$(node --version 2>/dev/null | sed 's/v//' | cut -d. -f1-2)
        echo "$icon_node $version"
    fi
}

# ------------------------------------------------------------------
# 4. CUSTOM PROMPT COMPONENTS
# ------------------------------------------------------------------
prompt_user() {
    local user="%n"
    if [[ "$user" == "root" ]]; then
        echo "%F{red}${icon_root} ${user}%f"
    else
        echo "%F{green}${icon_user} ${user}%f"
    fi
}

prompt_host() {
    local host="%m"
    if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
        echo "%F{blue}${icon_github} ${host}%f"
    else
        echo "%F{blue}${host}%f"
    fi
}

prompt_path() {
    local path="%~"
    local home="~"
    if [[ "$path" == "$home"* ]]; then
        path="${path/#$home/󰋜}"
    fi
    echo "%F{cyan}${icon_folder} ${path}%f"
}

prompt_time() {
    echo "%F{gray}${icon_time} %*%f"
}

prompt_exit_code() {
    echo "%(?.%F{green}${icon_success}%f.%F{red}${icon_fail}%f)"
}

prompt_jobs() {
    local jobs=$(jobs -r | wc -l)
    if [[ $jobs -gt 0 ]]; then
        echo "%F{yellow}${icon_jobs} ${jobs}%f"
    fi
}

# ------------------------------------------------------------------
# 5. GIT PROMPT (combined)
# ------------------------------------------------------------------
git_prompt() {
    local branch=$(git_branch)
    local status=$(git_status)
    if [[ -n "$branch" ]]; then
        echo "%F{yellow}${branch}%f$status"
    fi
}

# ------------------------------------------------------------------
# 6. MULTILINE PROMPT
# ------------------------------------------------------------------
setopt prompt_subst

# Línea 1: Información de contexto
PROMPT='$(prompt_user)@$(prompt_host) $(prompt_path)$(prompt_time) $(prompt_jobs)
$(prompt_exit_code) '

# RPROMPT: Información de git y estado
RPROMPT='$(git_prompt)'

# ------------------------------------------------------------------
# 7. COMMAND EXECUTION TIME (opcional)
# ------------------------------------------------------------------
preexec() {
    timer=${timer:-$SECONDS}
}

precmd() {
    if [[ -n $timer ]]; then
        local elapsed=$((SECONDS - timer))
        unset timer
        if [[ $elapsed -gt 2 ]]; then
            local minutes=$((elapsed / 60))
            local seconds=$((elapsed % 60))
            if [[ $minutes -gt 0 ]]; then
                RPROMPT="%F{magenta}${minutes}m${seconds}s%f $RPROMPT"
            else
                RPROMPT="%F{magenta}${seconds}s%f $RPROMPT"
            fi
        fi
    fi
}

# ------------------------------------------------------------------
# 8. TERMINAL TITLE (opcional)
# ------------------------------------------------------------------
precmd() {
    # Actualizar título de la terminal
    print -Pn "\e]0;%~\a"
}

# ------------------------------------------------------------------
# 9. LINE CONTINUATION (para comandos largos)
# ------------------------------------------------------------------
PS2='%F{cyan}… %f'

# ------------------------------------------------------------------
