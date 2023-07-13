{
  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "nixpkgs/nixos-unstable";
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

        # build-time deps
        # from https://blog.thomasheartman.com/posts/bevy-getting-started-on-nixos
        nativeBuildInputs = (with pkgs; [
          rust-toolchain
          rust-analyzer

          # lld
          # clang

          # cargo-edit
          # cargo-watch

          # pkgconfig
          # udev
        ]);

        # shellHook = ''export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${pkgs.lib.makeLibraryPath [
        #   pkgs.alsaLib
        #   pkgs.udev
        #   pkgs.vulkan-loader
        # ]}"'';
      };
    });
}
