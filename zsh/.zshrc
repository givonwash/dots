# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'Specify: %d'
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' format 'Type of Completion: %d'
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' menu select=0
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/givon/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/zsh/.hist
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install

# Environment Variables
export DOTFILES="${HOME}/DotFiles"
export MANPAGER='nvim +Man!'
export EDITOR='nvim'
export PATH="${PATH}:${HOME}/.local/bin"

# Aliases
# -- General
alias ..="./.."
alias ...="./../.."
alias ....="./../../.."
alias .....="./../../../.."
alias ......="./../../../../.."
alias c="clear"
alias cp="cp -i"
alias e="exit"
alias l="ls -lah"
alias md="mkdir -p"
alias n="$EDITOR"
alias nn="n ${DOTFILES}/nvim/init.vim"
alias na="n ${DOTFILES}/alacritty/alacritty.yml"
alias nb="n ${DOTFILES}/bash/.bashrc"
alias ns="n ${DOTFILES}/sway/config"
alias nz="n ${DOTFILES}/zsh/.zshrc"
alias psi="pacman -Si"
alias pss="pacman -Ss"
alias pqi="pacman -Qi"
alias pqs="pacman -Qs"
alias psyu="sudo pacman -Syu"
alias sb="source ~/.bashrc"
alias sz="source ~/.zshrc"
alias yss="yay -Ss"
alias ysi="yay -Si"

# -- Git Related
alias g="git"
alias ga="g add"
alias gb="g branch"
alias gaa="g add --all"
alias gc="g commit --verbose"
alias gca="g commit --all --verbose"
alias gco="g checkout"
alias gconf="g config"
alias gd="g diff"
alias gf="g fetch"
alias gl="g log --graph --decorate --all"
alias gm="g merge"
alias gpush="g push"
alias gpull="g pull"
alias gs="g status"
alias gss="g stauts --short"
 
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

# Starship Prompt
eval $(starship init zsh)

# python-pywal Colors
(cat ${HOME}/.cache/wal/sequences &)

# Auto-suggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax Highlighting (NOTE: Must be at EOF)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
