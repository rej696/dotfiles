FROM ubuntu:24.04

# create user with same uid/gid as user
ARG UNAME=csl
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME
RUN userdel -r ubuntu
RUN echo "csl:csl" | chpasswd && usermod -a -G sudo $UNAME

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --allow-remove-essential --allow-downgrades \
# toolchain
  libc-bin \
  libc-dev-bin \
  libc6 \
  libc6-dbg \
  libc6-dev
RUN apt-get update && apt-get install -y \
  gcc \
  build-essential \
  openjdk-8-jre-headless \
  debconf \
  git \
# fsdk tools' deps
  man-db \
  unzip \
  rsync\
  make\
  ruby \
  patch \
  doxygen\
# unittest tooling
  python3 \
  python3-pip \
  python3-venv \
  virtualenv \
  sudo \
# code coverage
  lcov \
# tools
  wget \
  lsb-base \
  gcc-multilib \
  lsb-release \
  gnupg \
  software-properties-common \
# pic stuff
  build-essential \
  make \
  cmake \
  git \
  curl \
  tar \
  vim \
# dev tools
  tmux \
  tmate \
  gdb \
  gdb-multiarch \
  gcc \
  ripgrep \
  tmate \
  fd-find \
  tree \
  sed \
  gawk \
  perl \
  coreutils \
  nano \
  clang-format-17 \
  neovim \
  bear \
  cscope \
  entr \
  exuberant-ctags \
  jq \
  picocom \
  rlwrap \
  dc \
  libssl-dev

RUN gem install rake bundler:1.17.3 rspec respec

# install gcc-arm-none-eabi
RUN wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/6-2017q2/gcc-arm-none-eabi-6-2017-q2-update-linux.tar.bz2 && \
tar xf gcc-arm-none-eabi-6-2017-q2-update-linux.tar.bz2 -C /opt

# Install Pic compiler and toolchain
# COPY ./xc8-v2.45-full-install-linux-x64-installer.run /tmp/xc8-install.run
RUN wget https://ww1.microchip.com/downloads/aemDocuments/documents/DEV/ProductDocuments/SoftwareTools/xc8-v2.45-full-install-linux-x64-installer.run && chmod +x xc8-v2.45-full-install-linux-x64-installer.run
RUN ./xc8-v2.45-full-install-linux-x64-installer.run --mode unattended --netservername localhost --unattendedmodeui minimal
RUN rm xc8-v2.45-full-install-linux-x64-installer.run

RUN ln -s /opt/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-addr2line /usr/local/bin/
RUN ln -s /opt/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-ar /usr/local/bin/
RUN ln -s /opt/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-as /usr/local/bin/
RUN ln -s /opt/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-elfedit /usr/local/bin/
RUN ln -s /opt/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-gcc /usr/local/bin/
RUN ln -s /opt/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-gcc-6.3.1 /usr/local/bin/
RUN ln -s /opt/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-gcc-ar /usr/local/bin/
RUN ln -s /opt/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-gcc-nm /usr/local/bin/
RUN ln -s /opt/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-gcc-ranlib /usr/local/bin/
RUN ln -s /opt/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-gcov /usr/local/bin/
RUN ln -s /opt/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-gcov-dump /usr/local/bin/
RUN ln -s /opt/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-gcov-tool /usr/local/bin/
RUN ln -s /opt/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-gdb /usr/local/bin/
RUN ln -s /opt/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-gdb-py /usr/local/bin/
RUN ln -s /opt/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-gprof /usr/local/bin/
RUN ln -s /opt/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-ld /usr/local/bin/
RUN ln -s /opt/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-ld.bfd /usr/local/bin/
RUN ln -s /opt/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-nm /usr/local/bin/
RUN ln -s /opt/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-objcopy /usr/local/bin/
RUN ln -s /opt/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-objdump /usr/local/bin/
RUN ln -s /opt/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-ranlib /usr/local/bin/
RUN ln -s /opt/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-readelf /usr/local/bin/
RUN ln -s /opt/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-size /usr/local/bin/
RUN ln -s /opt/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-strings /usr/local/bin/
RUN ln -s /opt/gcc-arm-none-eabi-6-2017-q2-update/bin/arm-none-eabi-strip /usr/local/bin/
RUN ln -s /usr/bin/fdfind /usr/bin/fd # Alias fd correctly

WORKDIR /home/csl
USER ${UNAME}
RUN git clone --depth 1 https://github.com/rej696/dotfiles
RUN mv /home/csl/.bashrc /home/csl/.bashrc.bak && ln -s /home/csl/dotfiles/.bashrc /home/csl/.bashrc
RUN git clone --depth 1 https://github.com/junegunn/fzf.git /home/csl/.fzf && /home/csl/.fzf/install
RUN rm -f /home/csl/.fzf.bash && ln -s /home/csl/dotfiles/fzf.bash /home/csl/.fzf.bash
RUN mkdir /home/csl/.config && ln -s /home/csl/dotfiles/nvim.lazy /home/csl/.config/nvim
RUN ln -s /home/csl/dotfiles/.tmux.conf /home/csl/.tmux.conf
RUN ln -s /home/csl/dotfiles/.tmate.conf /home/csl/.tmate.conf
RUN ln -s /home/csl/dotfiles/tmux /home/csl/.tmux
RUN ln -s /home/csl/dotfiles/vim.raspberry /home/csl/.vim
RUN ln -s /home/csl/.vim/vimrc /home/csl/.vimrc
RUN ln -s /home/csl/dotfiles/gitconfig2 /home/csl/.gitconfig
RUN ln -s /home/csl/dotfiles/clangd /home/csl/.config/clangd
RUN cd /home/csl/dotfiles && git submodule update --init -- tmux && cd -

# update nvim
RUN nvim --headless "+Lazy! sync" "+TSInstall c" "+TSInstall python" "+TSInstall bash" +qa
RUN nvim --headless "+Lazy! sync" "+MasonInstall clangd" "+MasonInstall lua-language-server" "+MasonInstall python-lsp-server" +qa
RUN echo 'PS1="(docker) ${PS1}"' >> /home/csl/.bashrc
RUN touch /home/csl/.sudo_as_admin_successful

ENV TERM="xterm-256color"
ENV USER="csl"

RUN mkdir /home/csl/work
WORKDIR /home/csl/work

