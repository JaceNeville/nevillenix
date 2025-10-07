{ lib, ... }:
let
  path = ./.;
  entries = builtins.readDir path;
  moduleFiles = builtins.filter (name: name != "default.nix" && builtins.match ".*\\.nix" name != null)
    (builtins.attrNames entries);
  sortedFiles = lib.sort (a: b: a < b) moduleFiles;
  modules = map (name: import (path + "/" + name)) sortedFiles;
in
{
  imports = modules;
}
