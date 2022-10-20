#!/bin/sh
pushd ~/nixos-config
# sudo nix-collect-garbage --delete-older-than 7d
# nix flake update --commit-lock-file
sudo nixos-rebuild test --flake .# --impure
popd
