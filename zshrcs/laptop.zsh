
export PATH=$HOME/go/bin:$PATH

alias tm="tmux new -A -s 󰣇"
alias vim=nvim
alias bose='bluetoothctl connect BC:87:FA:44:FE:C2'
alias wakywaky='wol 50:EB:F6:5C:4C:59'
alias fullwifi='sudo killall -STOP NetworkManager'
alias open=xdg-open

set -o vi
if [[ -f "$HOME/.key-bindings.zsh" ]]; then
  source "$HOME/.key-bindings.zsh"
fi

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"


