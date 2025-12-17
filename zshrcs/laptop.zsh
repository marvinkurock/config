
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.platformio/penv/bin:$PATH

alias tm="tmux new -A -s 󰣇"
alias gpustat='while true; do x=$(cat /sys/class/drm/card0/device/power_state); if [[ $x == "D3cold" ]];then echo -n "🔵"; else echo -n "🔴"; fi; sleep 2; done'
alias vim=nvim
alias bose='bluetoothctl connect BC:87:FA:44:FE:C2'
alias wakywaky='wol 50:EB:F6:5C:4C:59'
alias fullwifi='sudo killall -STOP NetworkManager'
alias open=xdg-open
alias temp="sensors | grep 'temp[0-9]\|fan:'"
alias k=kubectl
alias kgp="kubectl get pods"

set -o vi
if [[ -f "$HOME/.key-bindings.zsh" ]]; then
  source "$HOME/.key-bindings.zsh"
fi

if [[ -f '/usr/share/fzf/key-bindings.zsh' ]] source /usr/share/fzf/key-bindings.zsh

if [[ -f '/usr/share/doc/fzf/examples/key-bindings.zsh' ]] source /usr/share/doc/fzf/examples/key-bindings.zsh
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"


