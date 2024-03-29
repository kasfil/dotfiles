#!/bin/sh

if [[ -x "$(command -v dnf5)" ]];
then
  alias upgrade-all="sudo dnf5 upgrade --refresh -y && sudo dnf autoremove -y && flatpak upgrade -y && pipx upgrade-all && brew upgrade";
else
  alias upgrade-all="sudo dnf upgrade --refresh -y && sudo dnf autoremove -y && flatpak upgrade -y && pipx upgrade-all && brew upgrade";
fi

alias wgup="sudo wg-quick up"
alias wgdown="sudo wg-quick down"

alias c=clear
alias ls=lsd

alias l="ls -l"
alias la="ls -a"
alias ll="ls -l"
alias lt="ls --tree"
