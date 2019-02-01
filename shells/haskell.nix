{ pkgs ? import <nixpkgs> {} }:

let
  inherit (pkgs)
    stdenv
    haskellPackages
  ;
  ghcWithPkgs = haskellPackages.ghcWithPackages (h: with h; [
    # Add needed haskell packages here
  ]);

in stdenv.mkDerivation {
  name = "ghc-dev-env";

  buildInputs = with pkgs; with haskellPackages; [
    ghcWithPkgs
    cabal-install
    # Add any needed binaries here
  ];
}
