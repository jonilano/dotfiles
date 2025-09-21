# Dotfiles

Personal dotfiles and configuration management for setting up my development environment.

## Features

- ✅ Easily install and remove symlinks for managed **dotfiles** and **config directories**.  
- 🔒 Safe backup of existing files/directories before overwriting (`<name>.bak`).  
- ⚙️ Supports installing or cleaning **all** managed files, or **individual** ones.  
- 🧩 Flexible setup via `Makefile` or `setup.sh`.  
- 🧼 Minimal and clean `.zshrc` configuration.  

## Managed Files

### Dotfiles (`$HOME`)

- `.gitconfig`  
- `.vimrc`  
- `.zshrc`  
- `.zshrc.local`  

### Config directories (`$HOME/.config`)

- `ghostty`  
- `karabiner`  
- `nvim`  
- `starship`  
- `tmux`  

## Clone Repository

```bash
# Clone dotfiles
git clone git@github.com:jonilano/dotfiles.git
cd dotfiles

# Initialize + fetch submodules
git submodule update --init --recursive
```

## Installation

You can install the dotfiles/configs using either the **Makefile** or the **setup.sh** script.

---

### Using Makefile

Install everything:

```bash
make install
```

Install a specific file (example: `.zshrc`):

```bash
make .zshrc
```

Install a config directory (example: `nvim`):

```bash
make nvim
```

Remove everything:

```bash
make clean
```

Remove a specific file/dir (example: `ghostty`):

```bash
make clean-ghostty
```

---

### Using setup.sh

Install everything:

```bash
./setup.sh install
```

Install a specific file or config dir (example: `.zshrc` or `nvim`):

```bash
./setup.sh install .zshrc
./setup.sh install nvim
```

Remove everything:

```bash
./setup.sh clean
```

Remove a specific file/dir:

```bash
./setup.sh clean tmux
```

---

## Behavior

- Existing files/directories are automatically backed up with a `.bak` suffix before symlinks are created.  
- Symlinks are created into your home directory (`$HOME`) or config directory (`$HOME/.config`) depending on the type.  

## Requirements

- GNU `make`  
- `bash` or compatible shell  

## Notes

- `.zshrc` sources `.zshrc.local` if it exists, allowing machine-specific customizations.  
- The default prompt is minimal: `user@host:cwd$`.  

## License

This project is for personal use.  
Feel free to fork and adapt it to your own needs!  

