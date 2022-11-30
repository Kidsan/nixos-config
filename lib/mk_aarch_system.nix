{ self, agenix, ... } @ inputs: name: nixpkgs:
nixpkgs.lib.nixosSystem (
  let
    inherit (builtins) attrValues;

    configFolder = "${self}/nixos";
    entryPoint = import "${configFolder}/${name}.nix";
    hardware = "${configFolder}/hardware/${name}.nix";
    secrets = import "${self}/secrets";
  in
  {
    system = "aarch64-linux";

    modules =
      [
        entryPoint
        hardware
        secrets
        agenix.nixosModule
      ];
    # ++ attrValues self.nixosModules
    # ++ attrValues self.mixedModules;
  }
)
