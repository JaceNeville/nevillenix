{ lib, config, pkgs, ... }:
{
  imports = [
    ../../modules/default.nix
  ];

  # Keep original stateVersion
  system.stateVersion = "23.11";

  systemd.tmpfiles.rules = [
    "d /var/lib/secrets/tailscale 0700 root root -"
  ];

  # Provide the auth key file referenced here (for example via sops-nix or by copying it during deployment).
  services.meshSidecar = {
    enable = true;
    authKeyFile = "/var/lib/secrets/tailscale/mesh-auth.key";
  };
}
