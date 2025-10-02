{ inputs, lib, config, pkgs, ... }:
{
  imports = import ../../modules/default.nix;

  # Keep original stateVersion
  system.stateVersion = "23.11";
}
