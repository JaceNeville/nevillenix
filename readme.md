# NixOS Flake Layout

This repository holds a modular NixOS configuration with a cleaned non-flake `configuration.nix` for quick drop-ins and a Flake-based layout for long-term growth.

## Directory Map

```
/etc/nixos/
├─ flake.nix
├─ flake.lock
├─ hosts/
│  └─ nixos/
│     ├─ configuration.nix
│     └─ hardware-configuration.nix
├─ modules/
│  ├─ base.nix
│  ├─ networking.nix
│  ├─ docker.nix
│  ├─ nfs.nix
│  ├─ default.nix
│  └─ services/
│     ├─ ersatztv.nix
│     ├─ plex.nix
│     └─ xteve.nix
└─ users/
   └─ jace.nix
```

## Migration Checklist

1. Back up the current `/etc/nixos` (e.g., `sudo git init && sudo git add .`).
2. Enable experimental features so `nix` understands Flakes (already handled in `modules/base.nix`).
3. Drop in `configuration.nix` if you want a cleaned monolithic setup before the Flake split.
4. Populate the new tree from this repo, including your real `hardware-configuration.nix`.
5. Update inputs as desired (`nix flake update`) to produce a proper `flake.lock`.
6. Build and switch with `sudo nixos-rebuild switch --flake .#nixos`.
7. If containers complain about permissions, either pin `users.users.nevillecasaadmin.uid = 1000;` or adjust `PUID/PGID` in the container modules.

## Notes

- Base module focuses on core locale/time defaults and CLI essentials only.
- Networking module configures NetworkManager, firewall ports, and Tailscale.
- Docker is enabled with `virtualisation.oci-containers` powering ErsatzTV and xTeVe modules.
- NFS mounts are automounted with `_netdev` to ensure networking is up first; associated directories are declared via `systemd.tmpfiles`.
- Track changes in git so upgrades and rollbacks stay simple.
- `modules/default.nix` collects the shared modules, user config, and hardware profile so both entry points import the exact same stack.
