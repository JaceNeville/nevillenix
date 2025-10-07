{ lib, config, pkgs, ... }:
{
  imports = [
    ../../modules/default.nix
  ];

  # Keep original stateVersion
  system.stateVersion = "23.11";
}
