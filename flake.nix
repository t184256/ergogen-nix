{
  description = "Ergonomic keyboard layout generator";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      getPkgs = pkgs: { ergogen = pkgs.callPackage ./default.nix { }; };
    in
      flake-utils.lib.eachDefaultSystem (system: {
        packages = let
          pkgs = import nixpkgs { inherit system; };
        in
          getPkgs pkgs;
      }) // {
        overlays.default = final: prev:
          getPkgs prev;

        mkpkgs = (system: overlays: let
          pkgs = import nixpkgs { inherit system overlays; };
        in
          {
            packages = getPkgs pkgs;
          });
      };
}
