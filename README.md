# NixOS-Config

This is a dotfiles repository containing the configuration for my [NixOS](https://nixos.org/) machines. It also manages user environments for users `kidsan` and `lobster` via [home-manager](https://github.com/nix-community/home-manager).

## Hosts

This configures nixos for the following hosts

+ _desktop_: my main machine for development, gaming, etc
+ _thinkpad_: my laptop, primarily for development
+ _monster_: raspberry pi 4 (image built with https://github.com/Robertof/nixos-docker-sd-image-builder)

## apply-system.sh

This is a script that lazily performs garbage collection for the nix store, does a git pull to update the flake, and then applies both the system and user configuration in nix. Based on Wil T's guides and the scripts he suggests (but much lazier).

## piImage

Build a base raspberry pi image with `nix build .#piImage`