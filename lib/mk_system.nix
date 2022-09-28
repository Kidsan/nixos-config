{ self, ... } @ inputs: name: nixpkgs:
nixpkgs.lib.nixosSystem (
  let
    inherit (builtins) attrValues;

    configFolder = "${self}/configuration";
    entryPoint = import "${configFolder}/${name}.nix";
    hardware = "${configFolder}/hardware/${name}.nix";
  in
  {
    system = "x86_64-linux";

    modules =
      [
        entryPoint
        hardware
      ]
      ++ attrValues self.nixosModules
      ++ attrValues self.mixedModules;
  }
)
