# macOS Dotfiles & System Configuration

> [!NOTE]
> The `master` branch is for macOS Sonoma. For macOS Monterey, please use the `monterey` branch.

A modular, automated dotfiles and system configuration setup for macOS. This project streamlines the provisioning of a new macOS environment by handling directory creation, application installation via Homebrew, configuration symlinking, and extensive system-level default tuning. It also features built-in support for switching between tiling window managers.

## Features

- **Automated Provisioning**: One-touch installation orchestrating environment setup, app installation, and config linking.
- **Homebrew Integration**: Automated installation of Homebrew and package management via `Brewfile`.
- **System Defaults Configuration**: Extensive customization of macOS defaults (Finder, Dock, Trackpad, Keyboard, UI/UX, Security).
- **Telemetry Reduction**: Dedicated scripts to disable unnecessary macOS background daemons and agents.
- **XDG Base Directory Support**: Configured to respect XDG standards (e.g., `~/.config`, `~/.local/share`).
- **Dynamic Window Manager Switching**: Make targets to seamlessly switch between `yabai` and `AeroSpace` via `skhd`.
- **Custom Font Installation**: Automatically installs custom fonts (Source Code Pro, Archivo) to the user library.

## Tech Stack

- **Languages**: Bash Scripting
- **Build Tools**: Make
- **Package Manager**: Homebrew
- **Window Managers**: yabai, AeroSpace
- **Hotkey Daemon**: skhd
- **System Tools**: macOS `defaults`, `launchctl`, `pmset`, `scutil`

## Project Structure

- `Makefile`: Entry point for installation and window manager selection.
- `_prep-env.sh`: Validates Full Disk Access and creates necessary XDG base directories.
- `_install-apps.sh`: Installs Homebrew, applies `Brewfile`, sets up `bash` as default, installs fonts, and starts services (like `skhd` and `LuLu`).
- `_relink-config.sh`: Symlinks application configurations into `~/.config`.
- `_relink-home.sh`: Symlinks root-level dotfiles (e.g., `.bashrc`, `.inputrc`, `~/bin`).
- `_set-defaults.sh`: Applies custom macOS system preferences and UI tweaks.
- `_stop-processes.sh`: Disables non-essential macOS telemetry agents and daemons.
- `configs/`: Directory containing all dotfiles, `Brewfile`, and fonts to be symlinked or installed.

## Installation Instructions

1. Clone this repository to your local machine (e.g., `~/dev/dotfiles`).
2. Ensure your Terminal application has **Full Disk Access** (System Settings > Privacy & Security > Full Disk Access).
3. Navigate to the repository root:
   ```bash
   cd ~/dev/dotfiles
   ```
4. Run the installation process via Make:
   ```bash
   make install
   ```
5. Follow any on-screen prompts for password authentication (required for Homebrew and system configurations).
6. Restart your computer once the scripts complete to ensure all macOS defaults take effect.

## Usage

### Managing Window Managers

This setup supports switching between `yabai` and `AeroSpace` using `skhd` for keybindings.

To switch to **yabai**:
```bash
make select-yabai
```

To switch to **AeroSpace**:
```bash
make select-aerospace
```

To view all available commands:
```bash
make help
```

## License

This project is licensed under the GNU General Public License v2.0 - see the [LICENSE](LICENSE) file for details.

