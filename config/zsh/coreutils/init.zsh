#!/usr/bin/env zsh
# vim:set sw=2 sts=2 ts=2 et:
#
# GNU CoreUtils aliases and alts setup
# Linux supported only

# setup colors
if [[ -s "$HOME/.dir_colors" ]]; then
  eval "$(dircolors --sh "$HOME/.dir_colors")"
else
  eval "$(dircolors --sh)"
fi

# General aliases
alias type="type -a"
alias mkdir="mkdir -p"
alias o='xdg-open'

# colored commands
if [[ "$TERM" != dumb ]] && (( $+commands[grc] )) ; then
  alias grep="${aliases[grep]:-grep} --color=auto"
  cmds=(
    cc \
    configure \
    cvs \
    docker \
    diff \
    dig \
    gcc \
    gmake \
    ip \
    last \
    make \
    mount \
    mtr \
    netstat \
    ping \
    ping6 \
    ps \
    ss \
    traceroute \
    traceroute6 \
    wdiff \
    whois \
    iwconfig \
  );
  if (( $+commands[grc] )); then
    if (( $+commands[$cmd] )) ; then
      alias $cmd="grc --colour=auto $(whence $cmd)"
    fi
  fi
  # df colored
  alias df="grc --colour=auto df -x squashfs -h"
  # ls/exa colored
  if (( $+commands[exa] )); then
    alias l="exa --group-directories-first -1a"
    alias la="exa --group-directories-first -a"
    alias ll="exa --group-directories-first -lghH"
    alias lt="exa -lhHgs modified"
    alias ls="exa --group-directories-first"
    alias tree="ll --tree"
  else
    alias l="grc --colour=auto ls --color --group-directories-first -1A"
    alias la="grc --colour=auto ls --color --group-directories-first -AC"
    alias ll="grc --colour=auto ls --color --group-directories-first -lh"
    alias lt="grc --colour=auto ls --color -lhtr"
    alias ls="grc --colour=auto ls --color --group-directories-first -C"
  fi

  # Clean up variables
  unset cmds cmd
fi

if (( $+commands[xclip] )); then
  alias pbcopy='xclip -selection clipboard -in'
  alias pbpaste='xclip -selection clipboard -out'
elif (( $+commands[xsel] )); then
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
fi

# clipboard
alias pbc='pbcopy'
alias pbp='pbpaste'

# rm w/ 10 second wait
setopt RM_STAR_WAIT
alias rm="${aliases[rm]:-rm} -I"

# screen lock
alias afk='loginctl lock-sessions'
