{ config, pkgs, ... }:
{
  programs.nix-ld.enable = true;

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
    };
    oci-containers = {
      backend = "docker";
    };
  };
}
