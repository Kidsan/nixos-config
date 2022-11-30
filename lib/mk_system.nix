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
    system = "x86_64-linux";

    modules =
      [
        entryPoint
        hardware
        agenix.nixosModule
        secrets
      ];
    # ++ attrValues self.nixosModules
    # ++ attrValues self.mixedModules;
  }
)
