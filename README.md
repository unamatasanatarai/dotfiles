# macOS Dotfiles & System Configuration

![macOS](https://img.shields.io/badge/macOS-Sonoma-000000?style=flat-square&logo=apple&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-Scripting-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white)
![Homebrew](https://img.shields.io/badge/Homebrew-Package_Manager-F28D1A?style=flat-square&logo=homebrew&logoColor=white)
![GNU Make](https://img.shields.io/badge/GNU_Make-Automation-0A0A0A?style=flat-square&logo=gnu&logoColor=white)
![License: GPL v2](https://img.shields.io/badge/License-GPL%20v2-blue.svg?style=flat-square)

![look-at-me](assets/look-at-me.png)

Opinionated macOS dotfiles targeting Sonoma and later. A single `make install` command provisions a fresh Mac from scratch, installing packages via Homebrew, symlinking configuration files into XDG-compliant locations, and applying comprehensive system hardening and UX tweaks.

## Features

- **Automated Provisioning**: One-touch installation orchestrating environment setup, app installation, and config linking.
- **Declarative Package Management**: Homebrew integration tracking formulae and casks via a `Brewfile`.
- **System Hardening & Defaults**: Comprehensive `defaults write` configuration for Finder, Dock, Trackpad, and Security, along with `launchctl` commands to disable unnecessary telemetry daemons.
- **Tiling Window Management**: AeroSpace configuration with `skhd` bindings for workspace switching and window focus.
- **XDG Base Directory Compliance**: Enforces standardized paths for user configuration, data, and state (`~/.config`, `~/.local/share`, etc.).
- **Modular Bash Environment**: Structured `.bashrc` utilizing isolated modules for prompts, aliases, and history.
- **Custom CLI Toolkit**: A suite of shell utilities including Git workflow helpers, template scaffolders, and system maintenance scripts.

## Tech Stack

- **Languages**: Bash Scripting
- **Build Tools**: GNU Make
- **Package Manager**: Homebrew
- **Window Management**: AeroSpace
- **Hotkey Daemon**: skhd
- **Terminal & Editor**: Alacritty, Vim, tmux

## Project Structure

- `Makefile`: Entry point for the installation process (`make install`) and dumping Homebrew state (`make dump-apps`).
- `scripts/`: Provisioning scripts executed sequentially during installation.
  - `prep-env.sh`: Validates Full Disk Access and creates necessary XDG base directories.
  - `install-brew.sh`: Installs Homebrew and applies the `Brewfile`.
  - `install-fonts.sh`: Installs custom fonts (Source Code Pro, Archivo) to `~/Library/Fonts`.
  - `setup-bash.sh`: Registers Homebrew Bash and sets it as the default login shell.
  - `relink-config.sh`: Idempotent script that symlinks application configurations into `~/.config`.
  - `relink-home.sh`: Symlinks root-level dotfiles (e.g., `.bashrc`, `.inputrc`, `~/bin`).
  - `launch-services.sh`: Starts essential background services (`skhd`, `LuLu`).
  - `setup-macos.sh`: Applies custom macOS system preferences and UI tweaks.
  - `disable-services.sh`: Disables non-essential macOS telemetry agents and daemons.
- `configs/`: Directory containing all dotfile targets, `Brewfile`, font files, and the custom `bin/` toolkit.

## Installation Instructions

> **Prerequisite:** Ensure your Terminal application has **Full Disk Access** (System Settings > Privacy & Security > Full Disk Access) before running the installation.

1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com/unamatasanatarai/dotfiles.git
   cd dotfiles
   ```
2. Run the installation pipeline:
   ```bash
   make install
   ```
3. Follow any on-screen prompts for password authentication (required for Homebrew installation and system configuration tweaks).
4. Restart your computer once the scripts complete to ensure all macOS defaults take effect.

## Usage

You can use the provided `Makefile` to manage the dotfiles:

```bash
# Display available targets
make help

# Run the complete installation and provisioning pipeline
make install

# Dump current Homebrew formulae and casks to the Brewfile
make dump-apps
```

## License

This project is licensed under the GNU General Public License v2.0 - see the `LICENSE` file for details.
