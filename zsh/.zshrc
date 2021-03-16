################################################################################
# Givon's .zshrc for Arch Linux
################################################################################

# python-poetry completion
fpath+="${HOME}/.zfunc"

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
export REPOS="${HOME}/repos"
export PATH="${PATH}:${HOME}/.local/bin:${HOME}/.cargo/bin"
export EDITOR="nvim"
export MANPAGER="nvim +Man!"
export STARSHIP_CONFIG="${HOME}/.config/starship/starship.toml"
# -- fzf Default Command
export FZF_DEFAULT_COMMAND="fd . --type file --full-path"
# -- bat Default Appearance
export BAT_THEME="base16"
# -- python dependency management
export PATH="$PATH:$HOME/.poetry/bin"


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
alias l="exa -la --git --time modified --time-style long-iso --group"
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
alias o="xdg-open"
alias p="pacman"
alias pqi="pacman -Qi"
alias pqs="pacman -Qs"
alias repos="cd ${REPOS}"
alias psi="pacman -Si"
alias pss="pacman -Ss"
alias psyu="sudo pacman -Syu"
alias q="exit"
alias sb="source ~/.bashrc"
alias sz="source ~/.zshrc"
alias tm="tmux"
alias ysi="yay -Si"
alias yss="yay -Ss"

# -- Git Related
alias g="git"
alias ga="git add"
alias gaa="git add --all"
alias gb="git branch"
alias gc="git commit --verbose"
alias gca="git commit --all --verbose"
alias gco="git checkout"
alias gconf="git config"
alias gd="git diff"
alias gf="git fetch"
alias ggr="git grep"
alias gl="git log --graph --decorate --summary --stat"
alias gll="git log --graph --decorate --all --summary --stat"
alias gm="git merge"
alias gpull="git pull"
alias gpush="git push"
alias gshow="git show"
alias gs="git status"
alias gss="git stauts --short"
alias gsw="git switch"

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
eval "$(starship init zsh)"

# Auto-suggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax Highlighting (NOTE: Must be at EOF)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
