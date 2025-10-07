{ config, lib, pkgs, modulesPath, ... }@args:
let
  repoUrl = "https://github.com/JaceNeville/nevillenix";
  remoteRepo = builtins.fetchGit {
    url = repoUrl;
    ref = "main";
  };
  remoteModulePath = remoteRepo + "/hosts/nixos/hardware-configuration.generated.nix";
  remoteModuleAttempt = builtins.tryEval (import remoteModulePath);
  localModule = import ./hardware-configuration.generated.nix;
  chosenModule =
    if remoteModuleAttempt.success then remoteModuleAttempt.value else localModule;
in
chosenModule args
