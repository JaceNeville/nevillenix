{ config, pkgs, ... }:
{
  imports = import ./modules/default.nix;

  system.stateVersion = "23.11";
}
