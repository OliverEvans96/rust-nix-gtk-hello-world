# Nix + Rust gtk-hello-world

This is a simple example of building a rust app via nix, with some C dependencies (GTK).

## Usage

Clone the repo, then run `nix develop` to enter a dev shell with the dependencies available, then `cargo build` (assuming you already have `cargo` and `rust` installed on your system).

Or, simply `nix run` to build and run the app.

You can even run the app without cloning the repo via `nix run github:oliverevans96/rust-nix-gtk-hello-world`.
