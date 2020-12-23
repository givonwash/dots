################################################################################
# Givon's .zshrc for Arch Linux
################################################################################

# Zsh Completions
zstyle ':completion*' auto-description 'Specify: %d'
zstyle ':completion*' completer _complete _ignored _approximate
zstyle ':completion*' expand prefix suffix
zstyle ':completion*' file-sort modification
zstyle ':completion*' format 'Type of Completion: %d'
zstyle ':completion*' ignore-parents parent pwd .. directory
zstyle ':completion*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion*' menu select=0
zstyle ':completion*' preserve-prefix '//[^/]##/'
zstyle ':completion*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion*' verbose true
zstyle :compinstall filename '/home/givon/.zshrc'
autoload -Uz compinit
compinit

# Zsh Options
HISTFILE=~/.cache/zsh/.hist
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep extendedglob nomatch notify
bindkey -v

# Environment Variables
export DOTFILES="${HOME}/DotFiles"
export PROJECTS="${HOME}/projects"
export PATH="${PATH}:${HOME}/.local/bin:${HOME}/.cargo/bin"
export EDITOR="nvim"
export MANPAGER="nvim +Man!"

# Aliases
# -- General
alias ......="./../../../../.."
alias .....="./../../../.."
alias ....="./../../.."
alias ...="./../.."
alias ..="./.."
alias c="clear"
alias cp="cp -i"
alias d="cd ${DOTFILES}"
alias e="exit"
alias l="ls -lah"
alias md="mkdir -p"
alias n="$EDITOR"
alias na="n ${DOTFILES}/alacritty/alacritty.yml"
alias nb="n ${DOTFILES}/bash/.bashrc"
alias nn="n ${DOTFILES}/nvim/init.vim"
alias ns="n ${DOTFILES}/sway/config"
alias nw="n +VimwikiIndex"
alias nwd="n +VimwikiDiaryIndex"
alias nwdt="n +VimwikiMakeDiaryNote"
alias nz="n ${DOTFILES}/zsh/.zshrc"
alias p="pacman"
alias pqi="pacman -Qi"
alias pqs="pacman -Qs"
alias proj="cd ${PROJECTS}"
alias psi="pacman -Si"
alias pss="pacman -Ss"
alias psyu="sudo pacman -Syu"
alias q="exit"
alias sb="source ~/.bashrc"
alias sz="source ~/.zshrc"
alias tm="tmux -f ${DOTFILES}/tmux/.tmux.conf"
alias ysi="yay -Si"
alias yss="yay -Ss"

# -- Git Related
alias g="git"
alias ga="g add"
alias gaa="g add --all"
alias gb="g branch"
alias gc="g commit --verbose"
alias gca="g commit --all --verbose"
alias gco="g checkout"
alias gconf="g config"
alias gd="g diff"
alias gf="g fetch"
alias ggr="g grep"
alias gl="g log --graph --decorate --all --summary --stat"
alias gm="g merge"
alias gpull="g pull"
alias gpush="g push"
alias gs="g status"
alias gss="g stauts --short"
alias gsw="g switch"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/givon/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/givon/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/givon/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/givon/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Manage ssh-agent
SSH_AGENT_DOTENV="${XDG_RUNTIME_DIR}/ssh-agent.env"
# -- Write stdout from ssh-agent to file if no current process
if ! pgrep -u "${USER}" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "${SSH_AGENT_DOTENV}"
fi
# -- If SSH_AUTH_SOCK env variable DNE, source previously saved file
if [[ ! "${SSH_AUTH_SOCK}" ]]; then
    . "${SSH_AGENT_DOTENV}" > /dev/null
fi

# Starship Prompt
eval $(starship init zsh)

# python-pywal Colors
(cat ${HOME}/.cache/wal/sequences &)

# Auto-suggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax Highlighting (NOTE: Must be at EOF)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
