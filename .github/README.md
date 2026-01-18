# my complex heaven...

<div align="center">
<img src="assets/NixOS.png" width="200" alt="NixOS Logo">
</div>

> *"You'll get there ! Running NixOS is a lot of fun, feels like there's always something to improve about your config."*  
> — **Elythh**


## ... Hosts

| Host | Type |
|------|------|
| `cherries` | Laptop |
| `aureliteiron` | Desktop |

## ... Installation 

0. Make sure nix-commands flakes and pipe-operators are enabled
1. Clone the repository
2. Edit `flake.nix` and change the username
3. For hardware configuration:
   - Delete `hardware.nix` to use `/etc/nixos/hardware-configuration.nix`
   - Or modify the existing file
   - May need `--impure` flag for detection

## ... TODO

- [x] Switch to window manager on `cherries`
- [x] Implement sops-nix for secrets management

## ... Credits

- [kewin-y](https://github.com/kewin-y) - LabWC configuration
- [elythh](https://github.com/elythh) - Structural inspiration and the main motivator 
- [astrid](https://github.com/eepy-goddess/astrid-flake) - River configuration
- [alexpkgs](https://github.com/alexpkgs) - Previous configuration
- [linuxmobile](https://github.com/linuxmobile) - Configuration references

---
**Budapest HU**
