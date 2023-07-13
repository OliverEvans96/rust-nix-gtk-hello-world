{
  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, fenix, nixpkgs, flake-utils }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      fenix-system = fenix.packages.x86_64-linux;
      rust-toolchain =
        (with fenix-system; combine [ default.toolchain complete.rust-src ]);

    in flake-utils.lib.eachDefaultSystem (system: {
      defaultPackage = pkgs.hello;
      devShell = pkgs.mkShell {
        name = "rust-env";
        src = ./.;

        nativeBuildInputs = (with pkgs; [
          rust-toolchain
          rust-analyzer

          glibc
          gtk4
          pkgconfig
        ]);
      };
    });
}
