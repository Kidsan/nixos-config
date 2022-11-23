{ self, ... } @ inputs: name: nixpkgs:
nixpkgs.lib.nixosSystem (
  let
    inherit (builtins) attrValues;

    configFolder = "${self}/nixos";
    entryPoint = import "${configFolder}/${name}.nix";
    hardware = "${configFolder}/hardware/${name}.nix";
  in
  {
    system = "aarch64-linux";

    modules =
      [
        entryPoint
        hardware
      ];
    # ++ attrValues self.nixosModules
    # ++ attrValues self.mixedModules;
  }
)
