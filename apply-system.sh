#!/bin/sh
pushd ~/nixos-config
nix flake update --commit-lock-file
sudo nixos-rebuild switch --flake .# --impure
popd
