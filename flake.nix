{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
    naersk.url = "github:nix-community/naersk";
  };

  outputs = { self, nixpkgs, flake-utils, naersk }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      naersk' = pkgs.callPackage naersk { };
      nativeBuildInputs = with pkgs; [ pkgconfig glibc gtk4 ];

    in flake-utils.lib.eachDefaultSystem (system: rec {
      defaultPackage = naersk'.buildPackage {
        inherit nativeBuildInputs;
        src = ./.;
      };

      devShell = pkgs.mkShell {
        inherit nativeBuildInputs;
        name = "rust-env";
        src = ./.;
      };

      apps.default = {
        type = "app";
        program = "${defaultPackage}/bin/gtk-hello-world";
      };
    });
}
