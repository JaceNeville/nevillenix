{ config, lib, pkgs, ... }:
{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 32400 8409 34400 ];
    };
  };

  services.tailscale.enable = true;
}
