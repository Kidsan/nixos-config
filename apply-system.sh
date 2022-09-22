#!/bin/sh
pushd ~/nixos-config
sudo nixos-rebuild switch --upgrade -I nixos-config=./nixos/configuration.nix
popd
