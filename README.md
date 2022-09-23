# IDE config for [Neovim](https://neovim.io/) with [Lua](https://www.lua.org/)

This repo is based on [A Basic Stable IDE config for Neovim](https://github.com/LunarVim/nvim-basic-ide) and [Neovim from scratch](https://github.com/LunarVim/Neovim-from-scratch).


Run `git config --global --add url."git@github.com:".insteadOf "https://github.com/"` to use SSH for cloning Plugins.


## Install [lazygit](https://github.com/jesseduffield/lazygit)

### On Windows

```powershell
scoop bucket add extras
scoop install lazygit
```

### On Ubuntu
```bash
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-35.]+')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit
```
