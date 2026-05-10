# macOS Dotfiles & System Configuration

![macOS](https://img.shields.io/badge/macOS-12%2B-000000?style=flat-square&logo=apple&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-Scripting-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white)
![Homebrew](https://img.shields.io/badge/Homebrew-Package_Manager-F28D1A?style=flat-square&logo=homebrew&logoColor=white)
![MacPorts](https://img.shields.io/badge/MacPorts-Package_Manager-3581B8?style=flat-square)
![GNU Make](https://img.shields.io/badge/GNU_Make-Automation-0A0A0A?style=flat-square&logo=gnu&logoColor=white)
![License: GPL v2](https://img.shields.io/badge/License-GPL%20v2-blue.svg?style=flat-square)

![Screenshot](assets/look-at-me.png)

A comprehensive, automated macOS provisioning system. This repository uses a single `make install` command to configure a fresh macOS installation with package managers, a tiling window manager, shell configurations, and system hardening tweaks based on the macOS version.

## Features

* **Automated Installation**: Single command provisioning orchestrating environment setup, script execution, and configuration linking.
* **Conditional Setup**: Detects macOS version to deploy either Yabai and MacPorts (macOS 12) or AeroSpace (newer than macOS 12).
* **Package Management**: Uses Homebrew with a `Brewfile` and MacPorts with a `MacPortsfile` to declaratively install tools and applications.
* **Tiling Window Management**: Integrates Yabai or AeroSpace for window management, alongside `skhd` for hotkey bindings.
* **System Hardening & Defaults**: Applies custom macOS system preferences, UI tweaks, and disables unnecessary macOS telemetry agents.
* **XDG Base Directory Compliance**: Enforces standardized paths for configuration files inside `~/.config`.
* **Pre-configured Tooling**: Includes configuration for Bash, Vim, Tmux, Git, and Alacritty.

## Tech Stack

* **Languages**: Bash Scripting
* **Build Tools**: GNU Make
* **Package Managers**: Homebrew, MacPorts
* **Window Management**: AeroSpace (macOS 13+), Yabai (macOS 12)
* **Hotkey Daemon**: skhd
* **Terminal & Editors**: Alacritty, Vim, Tmux

## Project Structure

* `Makefile`: Main entry point for the installation pipeline (`make install`) and package state dumping (`make dump-apps`).
* `scripts/`: Modular bash scripts executed sequentially during installation.
  * `prep-env.sh`: Prepares the environment and validates dependencies.
  * `install-apps.sh`: Entry script for package manager and window manager installation based on macOS version.
  * `install-brew.sh`, `install-brew-monterey.sh`, `install-brew-sonoma.sh`: Homebrew installation and formula execution.
  * `install-macports.sh`: MacPorts installation for macOS 12.
  * `install-fonts.sh`: Installs custom fonts.
  * `setup-bash.sh`: Configures Bash as the default shell.
  * `relink-config.sh`, `relink-home.sh`: Symlinks application configurations into standard directories.
  * `launch-services.sh`: Enables and starts background services.
  * `setup-macos.sh`, `disable-services.sh`: Applies macOS preferences and disables non-essential services.
* `configs/`: Contains application configurations (`.config/`), binary utilities (`bin/`), fonts, and package manifest files (`Brewfile`, `MacPortsfile`).
* `assets/`: Image assets for documentation.

## Installation Instructions

> **Prerequisite:** Ensure your Terminal application has **Full Disk Access** (System Settings > Privacy & Security > Full Disk Access) before running the installation script.

1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com/unamatasanatarai/dotfiles.git
   cd dotfiles
   ```

2. Run the automated installation pipeline:
   ```bash
   make install
   ```

3. Authenticate with your password when prompted for Homebrew/MacPorts installation and `sudo` actions.

4. Restart your computer after the scripts finish to ensure all macOS defaults and configurations take effect.

## Usage

Use the provided `Makefile` to manage your environment:

```bash
# View available commands
make help

# Run the complete installation and provisioning pipeline
make install

# Dump current Homebrew formulae and casks to the configs/Brewfile
make dump-apps
```

## License

This project is licensed under the GNU General Public License v2.0. See the [LICENSE](LICENSE) file for details.
