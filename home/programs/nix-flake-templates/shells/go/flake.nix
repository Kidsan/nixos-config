{
  description = "A sample go flake";

  # Nixpkgs / NixOS version to use.
  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";


  outputs = { self, nixpkgs }:
    let

      # to work with older version of flakes
      lastModifiedDate = self.lastModifiedDate or self.lastModified or "19700101";

      # Generate a user-friendly version number.
      version = builtins.substring 0 8 lastModifiedDate;

      # System types to support.
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

      # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Nixpkgs instantiated for supported system types.
      nixpkgsFor = forAllSystems (system: import nixpkgs {
        inherit system;
      });

    in
    {
      # Provide some binary packages for selected system types.
      packages = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          app = pkgs.buildGoApplication {
            nativeBuildInputs = [ ];
            buildInputs = [ ];
            pname = "app";
            inherit version;
            src = ./.;
          };
        });

      defaultPackage = forAllSystems (system: self.packages.${system}.app);

      devShell = forAllSystems (system:
        let pkgs = nixpkgsFor.${system};

        in with pkgs;
        mkShell {
          hardeningDisable = [ "all" ];
          nativeBuildInputs = [
            pkgs.bashInteractive
            pkgs.buildPackages.go_1_22
            pkgs.sqlc
            pkgs.go-migrate
          ];
        });
    };
}
