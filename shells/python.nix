{ pkgs ? import <nixpkgs> {} }:

let
  inherit (pkgs)
    stdenv
  ;

  # Select python version
  python = pkgs.python3

  pyWithPkgs = python.withPackages (p: with p; [
    # Add needed python packages here
  ]);

in stdenv.mkDerivation {
  name = "py-dev-env";
  buildInputs = [
    pyWithPkgs
    # Add any needed binaries here
  ];
}
