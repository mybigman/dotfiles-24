# vim:set ft=sh sw=2 sts=2 ts=2 et:
#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#


# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

if [[ -e /usr/share/terminfo/x/xterm-256color || -e /lib/terminfo/x/xterm-256color ]]; then
  export TERM='xterm-256color'
else
  export TERM='xterm-color'
fi

if [[ ! -z  "$(command -v chruby)" ]]; then
  chruby ruby
fi

# set cursor, to pipe
if [[ -o interactive ]] && [[ -t 2 ]]; then
  print -n -- "\033[1 q"
fi

# make sure vi opens vim
alias vmin='VIMCONFIG="~/.vim/min" VIMDATA="~/.local/share/vmin" nvim --noplugin -u ~/.vim/min/init.vim'
alias vi='nvim'
alias vim='vim'
alias vimdiff='nvim -d'
# Fix nested terminals
if [[ -n "$NVIM_LISTEN_ADDRESS" ]]; then
  if [ -x "$(command -v nvr)" ]; then
    alias nvim='nvr'
  else
    alias vi='echo "No nesting!"'
  fi
fi

# Create a rm alias, default alias too intrusive
alias rm='nocorrect rm'
alias rm="${aliases[rm]:-rm} -I"

# screen lock
alias afk='i3exit lock'

# diff
alias cdiff='command diff'

# firewalld alias
alias fwc='_ firewall-cmd'

# enable color
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# commonly used sudo programs
alias lsblk='sudo lsblk'
alias virsh='virsh -c qemu:///system'
alias virt-viewer='virt-viewer -c qemu:///system'
alias virt-install='sudo virt-install -c qemu:///system'

# password store
alias pwork="PASSWORD_STORE_DIR=$HOME/.work-pass-store pass"
alias ppers="PASSWORD_STORE_DIR=$HOME/.personal-pass-store pass"

# Delete all stopped containers.
alias dockercleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a | grep Exited |  docker ps -a | grep Exited | grep -oe "^\w*")'

# Delete all untagged images.
alias dockercleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'

# 10 second wait if you do something that will delete everything. I wish I'd had this before...
setopt RM_STAR_WAIT

# Enable color support for various tty utils
if [ -x /usr/bin/dircolors ]; then
  eval "$(dircolors ~/.dir_colors)"
fi

# fasd
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection

# todo
alias t='todo.sh'
alias m='buku'

# load custom functions
autoload -Uz alarm calc btheadphones

# wake-on-lan cal-fedora-vmm01
alias wake-server='sudo wakeonlan -i 10.255.250.255 4c:cc:6a:fc:f0:7f'

# bundle exec
alias be='TERM=xterm-256color bundle exec'

# kitchen
alias kitchen='TERM=xterm-256color kitchen'
alias k='TERM=xterm-256color kitchen'

# ssh
alias ssh='TERM=xterm-256color ssh'

# tmux
alias tmux="env TERM=xterm-256color tmux"

# sudo with path
alias sudoe='sudo env PATH=$PATH'

# unlock server
alias unlock-ryzen='until ping -c1 ryzen-vmm01 &>/dev/null; do :; done; ppers -c systems/ryzen-vmm01 && xclip -o -selection clipboard | ssh -p 222 root@ryzen-vmm01 cryptroot-unlock'
alias unlock-dev='until ping -c1 ryzen-dev-vm01 &>/dev/null; do :; done; ppers -c systems/ryzen-dev-vm01 && xclip -o -selection clipboard | ssh -p 222 root@ryzen-dev-vm01 cryptroot-unlock'

# gitignore.gi
function gi { curl -L -s https://www.gitignore.io/api/$@ ;}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Set PATH
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
