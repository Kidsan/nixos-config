#!/bin/sh
sudo nix-collect-garbage --delete-older-than 7d
home-manager expire-generations "-7 days"
