# feather NixOS Configuration

> Building something I can fuck with and actually enjoy using. That's it.

## Overview

A modern NixOS configuration using the dendritic pattern from [mightyiam/dendritic](https://github.com/mightyiam/dendritic) mixed with inspiration from [elythh/flake](https://github.com/elythh/flake). This setup features KDE Plasma 6 with a dark-only theme, security hardening, and a modular structure that's easy to extend and customize.

## Features

- 🌲 **Dendritic Layout** - Every file is a flake-parts module for maximum modularity
- 🖥️ **KDE Plasma 6** - Beautiful desktop environment with Plasma Manager
- 🌙 **Dark Mode Only** - No light mode, ever. Dark theme enforced everywhere
- 🔒 **Security Hardened** - Based on NixOS wiki security best practices
- 💻 **Nixvim** - Fully configured Neovim with LSP, Telescope, and dark theme
- 📦 **Flake-based** - Reproducible and declarative configuration
- 🎨 **Stylix** - System-wide theming with dark color schemes

## Structure

```
├── flake.nix              # Main flake definition
├── hosts/                  # System-specific configurations
│   ├── grovebringer/
│   └── aureliteiron/
├── home/                   # Home-manager configurations
│   └── profiles/
├── modules/                # Reusable modules (dendritic pattern)
│   ├── nixos/             # NixOS modules
│   │   ├── security.nix   # Security hardening
│   │   └── ...
│   └── home/              # Home-manager modules
│       ├── plasma-manager.nix  # KDE configuration
│       ├── nixvim.nix     # Neovim setup
│       └── ...
├── lib/                   # Helper functions
└── secrets/               # Encrypted secrets
```

## Quick Start

1. **Clone the repository:**
   ```bash
   git clone <your-repo-url> ~/.config/nixpkgs
   cd ~/.config/nixpkgs
   ```

2. **Rebuild your system:**
   ```bash
   sudo nixos-rebuild switch --flake .#grovebringer
   ```

3. **Rebuild home-manager:**
   ```bash
   home-manager switch --flake .#grovebringer
   ```

## Configuration Details

### KDE Plasma 6

- Uses Plasma Manager for declarative configuration
- Breeze Dark theme enforced system-wide
- Custom panel layout with essential widgets
- Wayland support with proper environment variables

### Security Features

- Firewall enabled by default
- AppArmor confinement
- Kernel hardening via sysctl
- Fail2ban intrusion prevention
- ClamAV antivirus
- Secure sudo configuration
- Disabled coredumps

### Nixvim

- Gruvbox dark colorscheme
- LSP support for multiple languages
- Telescope fuzzy finding
- Treesitter syntax highlighting
- Auto-completion with nvim-cmp

### Dark Theme Enforcement

- Stylix ensures system-wide dark theme
- Plasma Manager forces dark KDE theme
- No light mode options available
- All applications configured for dark mode

## Development

### Adding New Modules

Following the dendritic pattern, every `.nix` file is a flake-parts module:

1. Create a new file in `modules/nixos/` or `modules/home/`
2. Define your configuration as a NixOS module
3. Import it in your host/home configuration

Example module structure:
```nix
{ config, lib, pkgs, inputs, ... }:

{
  # Your configuration here
  programs.example.enable = true;
}
```

### Testing Changes

Use the provided development shell:
```bash
nix develop
```

Format your code:
```bash
nixfmt-rfc-style **/*.nix
```

Run checks:
```bash
deadnix **/*.nix
statix check
```

## Sources & Inspiration

- [mightyiam/dendritic](https://github.com/mightyiam/dendritic) - Dendritic pattern
- [elythh/flake](https://github.com/elythh/flake) - Flake structure
- [poacher/nix-config](https://codeberg.org/poacher/nix-dotfiles) - Plasma Manager usage
- [linuxmobile/kaku](https://github.com/linuxmobile/kaku) - Configuration ideas
- [NixOS Wiki](https://wiki.nixos.org/) - Security and best practices
- [Plasma Manager](https://github.com/nix-community/plasma-manager) - KDE configuration

## License

This project is licensed under the BSD 2-Clause License - see the [LICENSE](LICENSE) file for details.

## Timeline

- ✅ **Late April**: Planning phase
- 🔄 **May 20**: Implementation started
- ⏳ **Summer**: Testing and refinement
- 🎯 **July 20**: Target completion

---

*"Building something I can fuck with and actually enjoy using. That's it."*
