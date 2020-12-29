{ pkgs ? import ./nixpkgs.nix }:
let ghcs = ["ghc865" "ghc884" "ghc8101"];
in pkgs.lib.genAttrs ghcs
    (ghc: pkgs.haskell.packages."${ghc}".callCabal2nix "hs-openmoji-data" ./. {})
