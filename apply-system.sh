#!/bin/sh
pushd ~/nixos-config
git pull
sudo nixos-rebuild switch --flake .# --impure
home-manager switch --flake .
sudo nix-collect-garbage --delete-older-than 7d
home-manager expire-generations "-7 days"
popd
