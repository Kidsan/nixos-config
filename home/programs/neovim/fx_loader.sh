#! /usr/bin/env nix-shell
#! nix-shell -i bash -p patchelf

# Fixes linking for NixOS 
# ./fx_loader.sh ~/.local/share/nvim/mason/packages/rust-analyzer/rust-analyzer
for binary in ${@}
do
  patchelf \
    --set-interpreter "$(cat ${NIX_CC}/nix-support/dynamic-linker)" \
    "${binary}"
done
