export HISTFILE=$ZDOTDIR/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

alias code="code --enable-features=UseOzonePlatform --ozone-platform=wayland"

eval "$(starship init zsh)"