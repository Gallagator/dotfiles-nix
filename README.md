# ❄️ NixOS dotfiles

*My configuration files for NixOS. Feel free to look around and copy!* 

# Special thanks to:
- [Siduck76's NvChad](https://github.com/siduck76/nvchad/)
- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Epsyle's NixOS Dotfiles](https://github.com/epsyle/snowflake/)

![Screenshot of my desktop](screenshot.png)

*My configuration files for NixOS. Feel free to look around and copy!* 

## Table of contents

- [Installation](#installation)
- [configuration.nix](#configuration.nix)
- [home.nix](#home.nix)
- [Conclusion](#conclusion)

## Installation

The first thing when installing my configurations is to make sure you are using the right channels for nixpkgs. 
The exact channels I use are: 
```
home-manager https://github.com/nix-community/home-manager/archive/master.tar.gz
nixos https://nixos.org/channels/nixos-unstable
```

If you don't want to have any issues using my dotfiles, make sure you are also using the same channels.

If you already have these channels set up, using my configs should be a breeze. Simply clone this repo and drop it into /etc/nixos. 
If you want, you can also set a seperate path for your NixOS configs with `export NIXOS_CONFIG=path/to/yourconfig`. 
Please be warned that it may not work perfectly out of the box. For best security, read over all the files to confirm there are no conflictions with your current system. 

## What each file does
| File name   | Description |
| ---------------- | ----------- |
| configuration.nix | Configures the base system |
| home.nix         | Configures some programs   |
| nvim.nix         | Configures neovim          | 
| zsh.nix          | Configures zsh             |
| packages.nix     | Installs packages          |
| dwm.nix          | Imports my build of dwm    |
| st.nix           | Imports my build of st     |

## ⚙️ configuration.nix
*It is likely you need to change a few things in this file to tailor the experience to what you use; I've included instructions in a comment at the top of the file.*

This file is the meat and potatoes of a NixOS configuration. It does all the basics, like setting up a hostname, users, networking, etc. Most of the stuff in here is pretty boring. Some points of interest include: 
- *The imports at top of the file*; this imports the hardware-configuration.nix file (which should not be touched and will be different on your system) and the [home-manager module](https://nixos.wiki/wiki/Home_Manager).
- *The neovim nightly overlay*; this essentially installs the latest and greatest neovim release, which I like since there are more features. 

Otherwise, this file basically just serves to make sure my system runs fine. The real configuration comes in the [home.nix](#home.nix).
## 🏠 home.nix

*This section is about home-manager, if you want a better explanation on how it works and how to use it, check out the [home-manager documentation](https://github.com/nix-community/home-manager#usage)*



This file sets up and configures home-manager. Home-manager is an awesome tool for managing your user's configurations, which not only makes it much easier to manage them, but also declutters your home directory. It is possible to have all your configs in one file, but I split the zsh and nvim configs into seperate files just to keep it clean.
I recommend that you make your own home-manager configuration, since mine will probably not suit how you want to use your system. The home-manager docs are great and I recommend checking them out.

Home-manager is used by setting options. These options define what program you want to configure, and then a certain set of settings to apply to said program. What home-manager actually does is take in options from your `home.nix` file (or whatever other file you use to configure it) and translates it to the native syntax for the program. This means that;
- All of your config files can have one syntax/file format
- You can have your entire system configured in one file (or as many as you like)
- The config is entirely reproduceable between any NixOS system
- Since some of the config files are moved, your home directory will generally be a little bit less cluttered

Sometimes home-manager has native support for configuration options, and sometimes you can just copy-paste your current config into a field (usually `extraConfig` or `extraOptions`). For example, for picom, you can use some of built-in configuration options: 
```  
services.picom = {
    enable = true;
    shadow = true;
    shadowOpacity = "0.3";
    extraOptions = ''
        shadow-radius = 20;
    '';
  };
  ```
  You can see that some of the settings you would see in a picom.conf file are here, but with a different syntax. `shadow = true;` uses the Nix language syntax to enable picom shadows, because it is a native setting with home-manager. 
  
  There are also some settings that are not supported by home-manager, in which case you can usually use the `extraOptions` setting (note: this is not a guarantee; check the man page for home-manager to config all the settings for your program). You can see that I have `shadow-radius = 20;` in `extraOptions`, which is what you would put in picom.conf.
  
  This general idea is how you configure home-manager, you can look at my `zsh.nix` file for a more in-depth config. 

## 📦 /packages/packages.nix

This file is what properly installs all of my packages/programs. It is not necessary to have this file, and most people will have this list in their configuration.nix. However, I like to seperate it into another file and source it in my configuration.nix, just to keep things neater. In the packages directory, it also imports a custom build of st and dwm. If you don't know or don't care about my builds or you want to use your own, you can remove the imports or change the custom package files.

## /scripts/
This directory is exactly what it sounds like; a set of scripts that I use often to make my life a little bit easier. They are very simple. Feel free to poke around and use them for yourself.

## 📝 neovim 

For my neovim configuration, since there are several lua files I also want to source, I decided to create an entire directory for it. To get the neovim nightly (latest version of neovim), add this at the top of `home.nix`: 
```
{ config, pkgs, ... }:
{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];
  # The rest of your config...
}
```
It is entirely possible to have your entire nvim config in the `home.nix`, but unless it is pretty small, things will get very messy, very quickly. I manage my plugins with the nix package manager, which makes it simple to install and apply plugins. If your desired plugins are not available, its possible to use vim-plug ([or you can add it to the nixpkgs repo!](https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/vim.section.md)). The rest of the config for neovim is pretty standard: the basic stuff goes in vim.nix and cofigs for specific plugins are sourced from their own seperate files.

## 🐚 zsh

My zsh config is also in it's own file, but much smaller than the neovim one. Home-manager has pretty good support for zsh configurations, which is very convenient. For plugin management, I use the fetchFromGitHub function in NixOS, but you can use oh-my-zsh, prezto, and a few others.

## Conclusion
And thats about it for my configuration. The code is registered under the MIT license, meaning you are allowed to use or distribute the code as you please, and if you need any help or have any suggestions, you can reach me on Discord at `notusknot#5622` or email me at `notusknot@gmail.com`.
