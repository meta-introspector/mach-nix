{
  pkgs ? import (import ./nixpkgs-src.nix) { config = {}; overlays = []; },
  dev ? false,
  extraModules ? [],
  ...
}:
let
  inherit (pkgs) lib;
  python = pkgs.python39;
  pythonDeps = lib.attrValues (import ./python-deps.nix { inherit python; inherit (pkgs) fetchurl; });
  pythonDepsDev = with python.pkgs; [
    pytest_6
    pytest-xdist
  ];
in
python.withPackages ( ps:
  pythonDeps
  ++ (lib.optionals dev pythonDepsDev)
  ++ extraModules
)
