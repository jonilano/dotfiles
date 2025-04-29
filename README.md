# Dotfiles

Personal dotfiles for setting up and managing my development environment.

## Features

- ✅ Easily install and remove symlinks for managed dotfiles.
- 🔒 Safe backup of existing configuration files before overwriting.
- ⚙️ Supports installing or cleaning all dotfiles at once, or individually.
- 🧩 Simple and extensible setup using `Makefile` or `setup.sh`.
- 🧼 Minimal and clean `.zshrc` configuration.

## Managed Dotfiles

- `.gitconfig`
- `.vimrc`
- `.zshrc`
- `.zshrc.local`

## Installation

You can install the dotfiles either using the **Makefile** or the **setup.sh** script.

### Using Makefile

Install all dotfiles:

```bash
make install
```

Install a specific dotfile (example for `.zshrc`):

```bash
make .zshrc
```

Remove all dotfiles:

```bash
make clean
```

Remove a specific dotfile (example for `.zshrc`):

```bash
make clean-.zshrc
```

### Using setup.sh

Install all dotfiles:

```bash
./setup.sh install
```

Install a specific dotfile:

```bash
./setup.sh install .zshrc
```

Remove all dotfiles:

```bash
./setup.sh clean
```

Remove a specific dotfile:

```bash
./setup.sh clean .zshrc
```

## Behavior

- When installing, if an existing file or symlink is found, it is automatically backed up as `<filename>.bak`.
- Symlinks are created from your home directory (`$HOME`) to the corresponding files inside the `dotfiles` repository.

## Requirements

- GNU `make`
- `bash` or compatible shell

## Notes

- `.zshrc` sources a local configuration file `.zshrc.local` if it exists, allowing machine-specific customizations without modifying the main `.zshrc`.
- The default prompt is a simple, minimal one showing `user@host:cwd$`.

## License

This project is for personal use.  
Feel free to fork and adapt it to your own needs!
