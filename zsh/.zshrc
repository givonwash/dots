fpath+="${HOME}/.zfunc"

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
zstyle :compinstall filename "${HOME}/.zshrc"
autoload -Uz +X compinit && compinit
autoload -Uz +X bashcompinit && bashcompinit

HISTFILE=~/.cache/zsh/.hist
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep extendedglob nomatch notify
bindkey -v

source $HOME/.config/sh/rc

eval "$(mcfly init zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
