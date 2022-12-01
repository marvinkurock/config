# export env variables
export EDITOR=nvim
export VISUAL=nvim
export wrockyou="/opt/wordlists/rockyou.txt"

# aliases
alias zeiss-forward="ssh -L 5050:localhost:5050 -L 1234:localhost:1234 -N zeiss"
alias internetip="curl ipecho.net/plain ; echo"

alias foodist_check="python3 /Users/marvinkurock/development/foodist/shop-checker/main.py"
alias charge="ioreg -w 0 -f -r -c AppleSmartBattery | grep Amperage"
alias burp="java --add-opens=java.desktop/javax.swing=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED  -jar /opt/jar/burpsuite_community_v2021.10.2.jar"
alias helm="nocorrect helm"
alias jupyter="source ~/tensorflow-metal/bin/activate && jupyter-lab"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

gh-deploy ()
{
  run_id=${1:-}
  env=${2:-}
  if [[ -z "$run_id" ]]; then
    echo "first parameter (run_id) required"
    exit 1
  fi
  if [[ -z "$env" ]]; then
    echo "second parameter (environment) required"
    exit 1
  fi
  repo=$(gh repo view --json nameWithOwner --jq '.nameWithOwner')
  if [[ -z "$repo" ]]; then
    echo "could not determine repo name"
    exit 1
  fi
  gh deploy -r $repo -e $env -i $run_id --approve
}

alias ls="lsd"
alias ll="ls -l"
alias la="ls -la"
alias lg="lazygit"

alias ranger=". ranger"
# alias tf=terraform@1

alias k=kubectl
alias kcc="k config get-contexts"
alias kgp="k get pods"
alias kdp="k describe pod"
alias kd="k describe"
alias kgns="k get ns"
alias kgs="k get services"
alias kds="k describe service"
alias kgde="k get deployment"
alias kdde="k describe deployment"
alias kgi="k get ingress"
alias kdi="k describe ingress"
alias kgir="k get ingressroute"
alias kdir="k describe ingressroute"
alias kl="k logs"
alias klf="k logs --follow=true"
alias kx="k exec -it"
ksn()
{
    kubectl config set-context --current --namespace="$1"
}
alias kcns="kubectl config view --minify | grep namespace:"
alias kdn="kubectl describe node"
alias kgn="kubectl get nodes"
alias ktn="kubectl top nodes"
alias ktp="kubectl top pods"
alias kuc="k config use-context"

update()
{
  git add .;
  if [[ $1 ]]
  then
    echo $1;
    git commit -m "$1"
  else
    echo "update";
    git commit -m "update"
  fi
  git push;
}



setopt cdablevars
dev=~/development/
techex=~/Documents/Work/Tech\ Excellence\ GmbH/
avax=/Users/marvinkurock/development/techex/avax

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/marvinkurock/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/marvinkurock/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/marvinkurock/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/marvinkurock/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

set -o vi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden'
    export FZF_CTRL_T_COMMAND='rg --files --hidden'
fi
if type fd &> /dev/null; then
  _fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
  }

  # Use fd to generate the list for directory completion
  _fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
  }
fi
