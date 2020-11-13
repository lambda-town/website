{ pkgs ? import <nixpkgs> {} }:
let 
  inherit (pkgs) haskellPackages;
  buildInputs = with pkgs; [
    stack
    sass
    libiconv
    zlib
  ];
in pkgs.stdenv.mkDerivation {
  name = "lambda-town-shell";
  inherit buildInputs;
}
