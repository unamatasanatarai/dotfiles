# Homebrew and Dotfiles Setup

This project provides a set of scripts to automate the setup of a macOS environment, including dotfiles, system preferences, and Homebrew package installation. The included Makefile orchestrates the process for easy execution.

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/unamatasanatarai/dotfiles.git
   cd dotfiles
   ```

2. Run the setup:
   ```bash
   make
   ```

   This will execute the `all` target, which runs the `dotfiles`, `osx`, and `apps` tasks in sequence.

## Makefile Targets

The `Makefile` provides the following targets:

- **`make all`**: Runs `dotfiles`, `osx`, and `apps` to fully configure the environment.
- **`make dotfiles`**:
  - Executes `_relink-config.sh` to set up configuration files.
  - Executes `_relink-home.sh` to link dotfiles to the home directory.
  - Executes `_prep-env.sh` to prepare the environment (e.g., setting up variables or paths).
- **`make osx`**:
  - Executes `_set-defaults.sh` to configure macOS system preferences.
- **`make apps`**:
  - Executes `_install-apps.sh` to install applications (likely via Homebrew or other methods).
- **`make brewdump`**:
  - Runs `brew bundle dump --force --describe --file=./configs/Brewfile` to generate a `Brewfile` in the `./configs/` directory, capturing the current Homebrew setup with descriptions.

## Custom Brewfile Location

The `brewdump` target saves the Brewfile to `./configs/Brewfile`. To install packages from this custom Brewfile, use:
```bash
brew bundle install --file=./configs/Brewfile
```

## Usage

- To set up your environment from scratch, run:
  ```bash
  make
  ```
- To update only dotfiles, run:
  ```bash
  make dotfiles
  ```
- To regenerate the Brewfile, run:
  ```bash
  make brewdump
  ```

## Contributing

Feel free to open issues or submit pull requests to improve the scripts or add new features.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
