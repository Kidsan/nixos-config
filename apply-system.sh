#!/bin/sh
pushd ~/nixos-config
nix flake update --commit-lock-file
sudo nixos-rebuild switch --flake .# --impure
# sudo nixos-rebuild switch --upgrade -I nixos-config=./nixos/configuration.nix
popd
