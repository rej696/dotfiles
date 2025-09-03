# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
#
# Keymaps: https://gist.github.com/tuxfight3r/60051ac67c5f0445efee
#
# C-b, C-f character back and forth
# M-b, M-f word back and forth
# C-a, C-e, home and end
# C-]-x, find x (next occurance)
# M-C-]-x FIND x (previous occurance)
# C-d delete character after cursor
# M-d delete word after cursor
# C-k delete all  after cursor
# C-h backspace before cursor
# C-w word backspace before cursor
# M-backspace word backspace before cursor
# C-u backspace all before cursor
# C-z background process
# C-_, C-x, C-u undo
# M-t swap words
# C-r history
# C-p previous command in history
# C-n next command in history
# C-xC-e edit commandline in editor (exit vim with :cq to cancel)
#
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
#HISTSIZE=1000
#HISTFILESIZE=2000
# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=-1
export HISTSIZE=-1
export HISTTIMEFORMAT="[%F %T] "
export HISTCONTROL=erasedups # don't keep duplicate commands in history
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
    alacritty) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ -f /usr/lib/git-core/git-sh-prompt ]; then
    source /usr/lib/git-core/git-sh-prompt
elif [ -f /usr/share/git/completion/git-prompt.sh ]; then
    source /usr/share/git/completion/git-prompt.sh
fi

git_basename() {
    git_root=$(git rev-parse --show-toplevel 2> /dev/null)
    if [ -n "$git_root" ]; then
        # echo -e '\033[01;31m[\033[01;32m'$(basename $git_root)'\033[01;31m:\033[01;34m'$(__git_ps1)'\033[01;31m]'
        # echo -e '\033[01;31m[\033[01;32m'$(basename $git_root)'\033[01;31m:\033[03;34m'$(__git_ps1)'\033[01;31m]'
        if [ $git_root != $PWD ]; then
            # \001 and \002 are the same as \[ and \] in the prompt, for wrapping formatting codes
            # Not doing this prevents the prompt from wrapping correctly for long lines
            echo -e '\001\033[03;02;32m\002'$(basename $git_root)'\001\033[00;01;31m\002/'
        fi
    fi
}


if [ "$color_prompt" = yes ]; then
    # PS1='${debian_chroot:+($debian_chroot)}$(git_basename) \[\033[01;31m\][\[\033[01;32m\]\W\[\033[01;31m\]] \[\033[01;32m\]\$ \[\033[00m\]'
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\][$(git_basename)\[\033[01;32m\]\W\[\033[01;31m\]]\[\033[03;34m\]$(__git_ps1) \[\033[00;01;32m\]\$ \[\033[00m\]'
else
    PS1='${debian_chroot:+($debian_chroot)}[\W] \$ '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    test -r ~/dotfiles/.dircolors && eval "$(dircolors -b ~/dotfiles/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/dotfiles/.bash_aliases ]; then
    . ~/dotfiles/.bash_aliases
fi
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ "$TERM" = "linux" ]; then
    _SEDCMD='s/.*\*\.color\([0-9]\{1,\}\).*#\([0-9a-fA-F]\{6\}\).*/\1 \2/p'
    for i in $(sed -n "$_SEDCMD" $HOME/.Xresources | awk '$1 < 16 {printf "\\e]P%X%s", $1, $2}'); do
        echo -en "$i"
    done
    clear
fi

man() {
    env \
    LESS_TERMCAP_mb="$(printf "\e[1;31m")" \
    LESS_TERMCAP_md="$(printf "\e[1;31m")" \
    LESS_TERMCAP_me="$(printf "\e[0m")" \
    LESS_TERMCAP_se="$(printf "\e[0m")" \
    LESS_TERMCAP_so="$(printf "\e[45;30m")" \
    LESS_TERMCAP_ue="$(printf "\e[0m")" \
    LESS_TERMCAP_us="$(printf "\e[1;32m")" \
    man "${@}"
}

# wt is for working with git worktrees, will switch directory to the argument passed to it.
# You can use regular repos for work-trees, but you might want to create a blank commit at the root:
#    git checkout $(git commit-tree $(git hash-object -t tree /dev/null) < /dev/null)
# To add a branch/worktree from remote, `git worktree add <path> <branch-name>`
# To create a new branch/worktree, `git worktree add -b <new-branch-name> <path> <commit/branch to branch from>`
wt() {
    directory=$(git worktree list --porcelain | grep -E 'worktree ' | awk '$0~v' v="${1}" | cut -d ' ' -f2-)
    if [ -z $directory ]; then
        return 1;
    fi
    cd "${directory}"
}

export EDITOR="nvim" # set the default editor to neovim

export PATH=~/.local/bin:$PATH
export MANPATH=~/.local/share/man:$MANPATH
[ -s "$HOME/.cargo" ] && . "$HOME/.cargo/env"
export PYTHONSTARTUP="${HOME}/dotfiles/pyreplrc.py"


# Run janet-server to start server, then ConjureConnect, then run janet-client to connect to shared repl
alias janet-server='janet -e "(import spork/netrepl) (netrepl/server-single)" 2&> /dev/null &'
alias janet-client='janet -e "(import spork/netrepl) (netrepl/client)"'

alias lisp="rlwrap ros run --eval '(ql:quickload :swank)' --eval '(swank:create-server :dont-close t)'"
alias dc="rlwrap dc"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

PATH="${HOME}/.perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="${HOME}/.perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="${HOME}/.perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"${HOME}/.perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=${HOME}/.perl5"; export PERL_MM_OPT;

