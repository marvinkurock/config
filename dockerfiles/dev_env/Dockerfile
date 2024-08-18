FROM ubuntu:24.04

WORKDIR /root
RUN apt update && apt install -y curl wget git python3 tar gzip ripgrep gcc nano vim bash zsh xz-utils
RUN curl -LO https://dl.k8s.io/release/$\(curl -LS https://dl.k8s.io/release/stable.txt\)/bin/linux/amd64/kubectl && chmod +x ./kubectl && mv
# RUN wget https://github.com/derailed/k9s/releases/download/v0.32.4/k9s_Linux_amd64.tar.gz && tar -xf k9s_Linux_amd64.tar.gz && mv k9s /usr/
RUN curl https://nodejs.org/dist/v20.15.0/node-v20.15.0-linux-x64.tar.xz -o nodejs.tar.xz &&    tar -xf nodejs.tar.xz -C /opt &&        echo bin:$HOME/bins:$PATH"' >> ~/.bashrc &&  rm nodejs.tar.xz
RUN curl -L https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz -o nvim.tar.gz &&     ls -lah && tar -xf nvim.tar.gnvim-linux64/bin:$PATH"' >> ~/.bashrc &&        rm nvim.tar.gz
COPY config/.config/nvim .config/nvim

# RUN wget https://go.dev/dl/go1.22.5.linux-amd64.tar.gz && tar -C /opt -xzf go1.22.5.linux-amd64.tar.gz && echo 'export PATH="$PATH:/opt/go/

RUN ls -lah /opt/nvim-linux64/bin && cat .bashrc
RUN bash -c 'source ~/.bashrc && export PATH="$PATH:/opt/nvim-linux64/bin:/opt/node-v20.15.0-linux-x64/bin" && echo $PATH && nvim --headless nInstall pyright yaml-language-server bash-language-server" +qa && nvim --headless "+TSInstallSync! yaml bash python json go" +qa'

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN wget https://get.helm.sh/helm-v3.15.2-linux-amd64.tar.gz && tar -zxvf helm-v3.15.2-linux-amd64.tar.gz && mkdir bins && mv linux-amd64/hel
RUN curl https://github.com/argoproj/argo-cd/releases/download/v2.9.18/argocd-linux-amd64 --create-dirs -o ~/bins/argocd
RUN curl https://dl.min.io/client/mc/release/linux-amd64/mc \
  --create-dirs \
  -o ~/bins/mc
RUN wget https://github.com/junegunn/fzf/releases/download/0.53.0/fzf-0.53.0-linux_amd64.tar.gz && tar -C bins/ -xzf fzf-0.53.0-linux_amd64.t
RUN chmod +x bins/*


COPY config/.tmux.conf.local .tmux.conf
