#!/bin/sh
pushd ~/nixos-config
sudo nixos-rebuild switch --upgrade -I ./nixos/configuration.nix
popd