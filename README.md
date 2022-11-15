# NixOS-Config

This is a dotfiles repository containing the configuration for (some of) my [NixOS](https://nixos.org/) machines. As well as a user `kidsan` via [home-manager](https://github.com/nix-community/home-manager).

## Hosts

This configures nixos for the following hosts

+ _desktop_: my main machine for development, gaming, etc
+ _thinkpad_: my laptop, primarily for development

I have some other machines (raspberry-pis and an m1 macbook) that I will add to this repository in future.

## apply-system.sh

This is a script that lazily performs garbage collection for the nix store, updates the flake, and then applies both the system and user configuration in nix. Based on Wil T's guides and the scripts he suggests (but much lazier). I will be removing the flake update step and making that a github action in future.

## Why did you...?

If you find yourself thinking anything like that while reading my configuration the answer is more than likely because I am a noob and still learning. I also tend to do things in a messy way to see if it works and I am bad at coming back to tidy up after myself. Hopefully I can work on that. Otherwise, I am happy to find out how I did something wrong so feel free to correct me.