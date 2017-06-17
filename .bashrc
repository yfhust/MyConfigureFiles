# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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
HISTSIZE=1000
HISTFILESIZE=2000

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
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
alias pi='ssh -p 5555 pi@192.168.3.31'
alias bw='ssh -p 27000 yfhust@23.83.246.48'
alias p='export http_proxy=http://127.0.0.1:8118 && export https_proxy=http://127.0.0.1:8118 && export ftp_proxy=http://127.0.0.1:8118 && export rsync_proxy=http://127.0.0.1:8118 && HTTP_PROXY=${http_proxy} && HTTPS_RPOXY=${https_proxy} && export HTTP_PROXY && export HTTPS_PROXY'
alias px='export http_proxy=http://127.0.0.1:8087 && export https_proxy=http://127.0.0.1:8087 && export ftp_proxy=http://127.0.0.1:8087 && export rsync_proxy=http://127.0.0.1:8087 && HTTP_PROXY=${http_proxy} && HTTPS_RPOXY=${https_proxy} && export HTTP_PROXY && export HTTPS_PROXY'
alias pm='export http_proxy=http://127.0.0.1:4444 && export https_proxy=http://127.0.0.1:4444 && export ftp_proxy=http://127.0.0.1:4444 && export rsync_proxy=http://127.0.0.1:4444'
alias co='p && /opt/cxoffice/bin/crossover'
alias songs='cd /home/yfei/4.0T-Backup/Resilio-Sync/房角石-圣诗精选/MP3音频/ && play *.mp3'
alias rsl='cd /home/yfei/4.0T-Backup/Resilio-Sync/'
alias gs='git status'
alias ga='git add'
alias gA='git add -A'
alias gm='git commit -m'
alias gp='git push'

# Functions
function l2v() 
{
	scp -P 27000 -i /home/yfei/.ssh/id_rsa $1 yfhust@23.106.141.179:/home/yfhust/;
}

function v2l() 
{
	scp -P 27000 -i /home/yfei/.ssh/id_rsa yfhust@23.106.141.179:/home/yfhust/ $1;
}


# 运行zhcon

if [ `tty | grep tty` ]; then
	zhcon --utf8


fi


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

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

export NVM_DIR="/home/yfei/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

set -o vi

# tmux初始化设置
tmux_init()
{
    tmux new-session -s "kumu" -d -n "local"    # 开启一个会话
    tmux new-window -n "other"          # 开启一个窗口
    tmux split-window -h                # 开启一个竖屏
    tmux split-window -v "top"          # 开启一个横屏,并执行top命令
    tmux -2 attach-session -d           # tmux -2强制启用256color，连接已开启的tmux
}

# 判断是否已有开启的tmux会话，没有则开启
if which tmux 2>&1 >/dev/null; then
    test -z "$TMUX" && (tmux attach || tmux_init)
fi
