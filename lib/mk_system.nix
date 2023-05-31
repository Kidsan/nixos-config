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

        # This fixes nixpkgs (for e.g. "nix shell") to match the system nixpkgs
        ({ config, pkgs, options, ... }: { nix.registry.nixpkgs.flake = nixpkgs; })
        {
          # https://ayats.org/blog/channels-to-flakes/
          environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
          nix.nixPath = [ "nixpkgs=/etc/nix/inputs/nixpkgs" ];
        }

      ];
    # ++ attrValues self.nixosModules
    # ++ attrValues self.mixedModules;
  }
)
