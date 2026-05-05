# macOS Dotfiles


![macOS](https://img.shields.io/badge/macOS-Monterey-000000?style=flat-square&logo=apple&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-Scripting-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white)
![Homebrew](https://img.shields.io/badge/Homebrew-Package_Manager-F28D1A?style=flat-square&logo=homebrew&logoColor=white)
![MacPorts](https://img.shields.io/badge/MacPorts-Package_Manager-336699?style=flat-square)
![GNU Make](https://img.shields.io/badge/GNU_Make-Automation-0A0A0A?style=flat-square&logo=gnu&logoColor=white)
![License: GPL v2](https://img.shields.io/badge/License-GPL%20v2-blue.svg?style=flat-square)

> [!NOTE]
> The `master` branch is for macOS Sonoma. For macOS Monterey, please use the `monterey` branch.

![look-at-me](assets/look-at-me.png)

A macOS dotfiles repository that automates system configuration, package management, and environment setup. It ensures a consistent, reproducible development environment tailored specifically for macOS Monterey.

## Features

- **Automated Directory Setup:** Creates XDG base directories (`~/.config`, `~/.local/bin`, etc.) for clean environment management.
- **Package Management:** Installs packages via Homebrew and MacPorts. MacPorts is explicitly utilized as a fallback for compatibility, as Monterey's age can cause Homebrew to refuse certain installations.
- **Configuration Management:** Safely creates symlinks for dotfiles and application configurations without manual intervention.
- **System Defaults Automation:** Programmatically configures macOS system preferences, including Finder tweaks, Dock adjustments, Trackpad settings, and enhanced Security & Privacy controls.
- **Service Orchestration:** Automatically starts essential background services such as `skhd` and `LuLu` post-installation.
- **Font Setup:** Installs custom developer fonts directly to the system.

## Tech Stack

- **Languages**: Bash Scripting
- **Build Tools**: Make
- **Package Manager**: Homebrew, MacPorts
- **Window Managers**: yabai
- **Hotkey Daemon**: skhd
- **System Tools**: macOS `defaults`, `launchctl`, `pmset`, `scutil`
- 
## Project Structure

- `Makefile` — Primary entry point exposing the `install` and `dump-apps` commands.
- `scripts/prep-env.sh` — Prepares necessary directories and verifies Terminal permissions.
- `scripts/install-apps.sh` — Handles installation of Homebrew, MacPorts, fonts, and sets the default shell to Homebrew Bash.
- `scripts/relink-config.sh` — Symlinks structured application configs to `~/.config`.
- `scripts/relink-home.sh` — Symlinks root dotfiles (e.g., `.bashrc`, `.vimrc`) directly to `$HOME`.
- `scripts/setup-macos.sh` — A comprehensive script applying over 50+ macOS system preference tweaks.
- `scripts/disable-services.sh` — Optimizes system performance by disabling unnecessary background services.
- `configs/` — Contains declarative configuration definitions (`Brewfile`, `MacPortsfile`), dotfiles, custom fonts, and local binaries.

## Installation Instructions

1. **Grant Permissions:** Ensure your Terminal application has "Full Disk Access" enabled in System Settings > Privacy & Security (required to apply certain macOS defaults like Safari).
2. **Clone the Repository:** Clone this project to your local machine.
3. **Run the Setup:** Execute the following command from the root directory:
   ```bash
   make install
   ```
   *Note: You may be prompted for your administrator password during the installation of Homebrew, MacPorts, and certain system tweaks.*

## Usage

The project utilizes a `Makefile` to simplify execution. The following commands are available:

- `make install` — Runs the full automation pipeline: preparing directories, installing apps, linking dotfiles, and applying macOS defaults.
- `make dump-apps` — Captures the currently installed Homebrew and MacPorts packages, saving them to `configs/Brewfile` and `configs/MacPortsfile` to track new additions.

## Configuration

Package lists are managed declaratively in the `configs/` directory:
- `configs/Brewfile`: Contains all Homebrew formulae and casks to be installed.
- `configs/MacPortsfile`: Contains all MacPorts to be installed.

## License

This project is licensed under the GNU General Public License v2.0 - see the [LICENSE](LICENSE) file for details.
