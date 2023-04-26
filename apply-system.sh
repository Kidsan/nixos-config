#!/bin/sh
pushd ~/nixos-config
git pull
sudo nixos-rebuild switch --flake .#
home-manager switch --flake .
popd
