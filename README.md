# NixOS Configurations

```ShellSession
## rebuild system environment
$ rm -f flake.lock && git add . ':!hardware-configuration.nix' && sudo nixos-rebuild switch --flake .#myNixOS

## rebuild system environment
$ rm -f flake.lock && git add . ':!hardware-configuration.nix' && nix run nixpkgs#home-manager -- switch --flake .#myHome
```

## See
- [NixOS Manual](https://nixos.org/manual/nixos/stable/#ch-configuration)

### See also
- [NixOSで最強のLinuxデスクトップを作ろう](https://zenn.dev/asa1984/articles/nixos-is-the-best)

