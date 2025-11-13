#!/bin/env bash

if [[ ! -d "$HOME/repos" ]]; then
  mkdir -p $HOME/repos
  cd $HOME/repos
  git clone https://github.com/marvinkurock/config
fi

cd
if [[ ! -f "$HOME/.tmux.conf.local" ]]; then
  ln -s $HOME/repos/config/.tmux.conf.local $HOME/.tmux.conf.local
fi
if [[ ! -f "$HOME/.tmux.conf" ]]; then
  cd /opt
  sudo mkdir -p .tmux
  sudo chown $USER .tmux
  git clone https://github.com/gpakosz/.tmux.git /opt/.tmux
  ln -s /opt/.tmux/.tmux.conf $HOME/.tmux.conf
  cd
fi

if [[ ! -f "$HOME/.zshrc" ]]; then
  sudo apt install zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [[ -z "$(which pyenv)" ]]; then
  curl -fsSL https://pyenv.run | bash
fi
if [[ -z "$(which brave-browser)" ]]; then
  curl -fsS https://dl.brave.com/install.sh | sh
fi

if [[ ! -d "/opt/nvim" ]]; then
  cd
  sudo mkdir -p /opt/nvim
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
  sudo tar xf nvim-linux-x86_64.tar.gz -C /opt/nvim
  echo 'export PATH=/opt/nvim/nvim-linux-x86_64/bin:$PATH' >> $HOME/.zshrc
  ln -s $HOME/repos/config/.config/nvim $HOME/.config/
  echo 'EDITOR=nvim' >> $HOME/.zshrc
  echo 'alias vim=nvim' >> $HOME/.zshrc
fi

