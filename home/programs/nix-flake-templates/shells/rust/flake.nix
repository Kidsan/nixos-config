{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    utils.url = "github:numtide/flake-utils";
    cargo2nix.url = "github:cargo2nix/cargo2nix/unstable";
  };

  outputs = { self, nixpkgs, utils, rust-overlay, cargo2nix }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ (import rust-overlay) cargo2nix.overlays.default ];
        };
        manifest = (pkgs.lib.importTOML ./Cargo.toml).package;
        app = (pkgs: pkgs.rustPlatform.buildRustPackage {
          pname = manifest.name;
          version = manifest.version;
          cargoLock.lockFile = ./Cargo.lock;
          src = pkgs.lib.cleanSource ./.;
          buildInputs = [
            # pkgs.openssl 
          ];
          nativeBuildInputs = [
            # pkgs.pkg-config
          ];
          doCheck = false;
        });
        rustPkgs = pkgs.rustBuilder.makePackageSet
          {
            rustVersion = "1.75.0";
            packageFun = import ./Cargo.nix;
          };
      in
      rec
      {
        packages = {
          app = (rustPkgs.workspace.app { });
          docker = pkgs.dockerTools.buildLayeredImage {
            name = "";
            tag = if (self ? rev) then self.shortRev else "dirty";
            config.Cmd = [ "${packages.app}/bin/app" ];
            contents = [ packages.app ];
          };
        };

        defaultPackage = packages.app;

        devShell = with pkgs; mkShell {
          LD_LIBRARY_PATH = nixpkgs.lib.makeLibraryPath [
            # pkgs.openssl 
          ];
          buildInputs = [
            pkg-config
            (rust-bin.stable.latest.default.override {
              extensions = [ "rust-src" ];
            })
            bashInteractive
            cargo-watch
            sqlx-cli
          ];
          RUST_SRC_PATH = rustPlatform.rustLibSrc;
          shellHook = ''
            export OPENSSL_DIR="${openssl.dev}"
            export OPENSSL_LIB_DIR="${openssl.out}/lib"
          '';
        };
      });
}
