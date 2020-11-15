{ pkgs ? import <nixpkgs> {} }:
let 
  inherit (pkgs) haskellPackages;
  buildInputs = with pkgs; [
    stack
    sass
    libiconv
    zlib
    nodejs
  ];
in pkgs.stdenv.mkDerivation {
  name = "lambda-town-shell";
  inherit buildInputs;
}
