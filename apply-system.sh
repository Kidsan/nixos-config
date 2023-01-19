#!/bin/sh
pushd ~/nixos-config
git pull
sudo nixos-rebuild switch --flake .# --impure
home-manager switch --flake .
popd
