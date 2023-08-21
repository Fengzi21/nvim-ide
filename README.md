# IDE config for [Neovim](https://neovim.io/) with [Lua](https://www.lua.org/)

This repo is based on [Neovim from scratch](https://github.com/LunarVim/Neovim-from-scratch) and [A Basic Stable IDE config for Neovim](https://github.com/LunarVim/nvim-basic-ide).


## Features
- To be added!


## Install Dependencies

### Python and Node.js client
```bash
# by pip
pip install pynvim

# by conda
conda install -c conda-forge pynvim

npm i -g neovim
```

### [ripgrep](https://github.com/BurntSushi/ripgrep)
- `telescope.nvim` needs this to work.
- [See details](https://github.com/BurntSushi/ripgrep#installation)

```bash
# for Ubuntu
sudo apt-get update -y
sudo apt-get install ripgrep

# for macOS
brew install ripgrep

# or by cargo in all platforms
cargo install ripgrep
```

### X11 support

```bash
# Ubuntu
sudo apt-get upgrade libstdc++6
sudo apt install xsel
```

### Wayland support
```bash
# Ubuntu
sudo apt install wl-clipboard

# or by cargo
cargo install wl-clipboard-rs-tools
```

### [fd](https://github.com/sharkdp/fd)

```bash
# Ubuntu
sudo apt install fd-find

# or by cargo
cargo install fd-find

# from source
wget https://github.com/sharkdp/fd/releases/download/v8.4.0/fd-v8.4.0-i686-unknown-linux-musl.tar.gz
tar -zxvf fd-v8.4.0-i686-unknown-linux-musl.tar.gz
cd fd-v8.4.0-i686-unknown-linux-musl
cp fd ~/.local/bin
cp fd.1 ~/.local/share/man/man1
mandb
```

### [fasd](https://github.com/clvv/fasd)

```bash
# on Ubuntu
sudo apt install fasd -y

# from source
git clone git@github.com:clvv/fasd.git
cd fasd
PREFIX=$HOME/.local make install
```

## Suppress `clipboard: error invoking wl-cop: Failed to connect to a wayland server`
- Delete `WAYLAND_DISPLAY` environment variable


## Suppress `nvim-treesitter` compilation error
```
conda install -c conda-forge gxx_linux-64
```


## Use SSH for cloning plugins from GitHub

```bash
git config --global --add url."git@github.com:".insteadOf "https://github.com/"
```


## Install language formatter

- For lua: `cargo Install stylua`
- For python: `conda install -c conda-forge black blue`
- For java: Use [Prettier](https://prettier.io/docs/en/install.html)
- For rust: Use [rustfmt](https://github.com/rust-lang/rustfmt)
- For Fortran: `conda install -c conda-forge fprettify`


## Install [lazygit](https://github.com/jesseduffield/lazygit)

- [See details](https://github.com/jesseduffield/lazygit#installation)

### on Windows
```powershell
scoop bucket add extras
scoop install lazygit
```

### on Ubuntu
```bash
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-35.]+')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit
```

### on macOS
```bash
brew install lazygit
# or
sudo port install lazygit
```

### or by Conda in all platform
```code
conda install -c conda-forge lazygit
```


## install [htop](https://github.com/htop-dev/htop)

1. Follow the [install instruction](https://github.com/htop-dev/htop)
2. By Conda

```bash
conda install -c conda-forge htop
```


## Install Hack [Nerd Font](https://www.nerdfonts.com/)

### Windows
- [See details](https://community.chocolatey.org/packages/nerdfont-hack):
```powershell
choco install nerdfont-hack
```

### Linux or macOS
1. Follow the [Quick Installation](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack#quick-installation)
2. By [getnf](https://github.com/ronniedroid/getnf.git)

## Jupytext
```bash
conda install -c conda-forge jupytext
```
