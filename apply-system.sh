#!/bin/sh
pushd ~/nixos-config
sudo nix-collect-garbage --delete-older-than 7d
nix flake update --commit-lock-file
sudo nixos-rebuild switch --flake .# --impure
home-manager expire-generations "-7 days"
home-manager switch --flake .#kidsan
popd
