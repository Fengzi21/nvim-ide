# IDE config for [Neovim](https://neovim.io/) with [Lua](https://www.lua.org/)

This repo is based on [A Basic Stable IDE config for Neovim](https://github.com/LunarVim/nvim-basic-ide) and [Neovim from scratch](https://github.com/LunarVim/Neovim-from-scratch).


## Install dependencies

```bash
sudo apt-get update -y

sudo apt-get install ripgrep     # for telescope.nvim

sudo apt-get upgrade libstdc++6

sudo apt install xsel            # for X11

sudo apt install wl-clipboard    # for wayland

pip install pynvim

npm i -g neovim

sudo apt install fd-find

sudo apt install fasd -y
```

Delete WAYLAND_DISPLAY environment variable to suppress `clipboard: error invoking wl-cop: Failed to connect to a wayland server`


## Use SSH for cloning plugins

```bash
git config --global --add url."git@github.com:".insteadOf "https://github.com/"
```


##  Install language formatter

- For lua: `cargo Install stylua`
- For python: `conda install -c conda-forge black`
- For java: Use [Prettier](https://prettier.io/docs/en/install.html)
- For rust: Use [rustfmt](https://github.com/rust-lang/rustfmt) 


## Install [lazygit](https://github.com/jesseduffield/lazygit)

### Windows

```powershell
scoop bucket add extras

scoop install lazygit
```

### Ubuntu

```bash
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-35.]+')

curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"

sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit
```


## Install Hack Nerd Font

### Windows: 
```powershell
choco install nerdfont-hack
```

### Linux

Follow the [Quick Installation](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack#quick-installation)
