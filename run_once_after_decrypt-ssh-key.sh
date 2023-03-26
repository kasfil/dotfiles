#!/bin/bash

# register ssh key
eval "$(ssh-agent -s)"
ssh-add $HOME/.ssh/id_ed25519

# set git username and email
git config --global user.name "kasfil"
git config --global user.email "kasf@tuta.io"
