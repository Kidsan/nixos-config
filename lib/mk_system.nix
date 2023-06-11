{ self, secrets, agenix, ... } @ inputs: name: nixpkgs:
nixpkgs.lib.nixosSystem (
  let
    inherit (builtins) attrValues;

    configFolder = "${self}/nixos";
    entryPoint = import "${configFolder}/${name}.nix";
    hardware = "${configFolder}/hardware/${name}.nix";

    secretsModule = secrets.nixosModules.${name} or { };

  in
  {
    system = "x86_64-linux";

    modules =
      [
        entryPoint
        hardware
        agenix.nixosModules.default
        secretsModule
        {
          environment.etc."nix/inputs/nixpkgs".source = inputs.nixos.outPath;
        }
      ];
    # ++ attrValues self.nixosModules
    # ++ attrValues self.mixedModules;
  }
)
