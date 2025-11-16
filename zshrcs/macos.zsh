
export PATH=$HOME/go/bin:$PATH
export rockyou=/opt/wordlists/rockyou.txt

alias tm="tmux new -A -s "
alias vim=nvim
alias wakywaky='wakeonlan 50:EB:F6:5C:4C:59'
alias open=xdg-open

alias k=kubectl
alias kgp="kubectl get pods"

set -o vi
if [[ -f "$HOME/.key-bindings.zsh" ]]; then
  source "$HOME/.key-bindings.zsh"
fi

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

if type lsd &>/dev/null; then 
  alias ls=lsd
  alias cat="bat --style=plain"
fi

if type brew &>/dev/null; then
  HOMEBREW_PREFIX=$(brew --prefix)
  # gnubin; gnuman
  for d in ${HOMEBREW_PREFIX}/opt/*/libexec/gnubin; do export PATH=$d:$PATH; done
  # I actually like that man grep gives the BSD grep man page
  #for d in ${HOMEBREW_PREFIX}/opt/*/libexec/gnuman; do export MANPATH=$d:$MANPATH; done
fi
