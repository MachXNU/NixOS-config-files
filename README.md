# NixOS Configuration Files

![Screenshot](./screenshots/screenshot-1.png)

This repo presents my NixOS configuration files from 5 hosts:

- a desktop (AMD CPU and iGPU, Nvidia eGPU)
- 2 laptops (Intel CPU and iGPU, Nvidia eGPU)
- a headless VM (emulated on macOS via UTM)
- a NAS (Intel CPU)

I am planning to add support for configuring a Mac with `nix-darwin` soon.

Desktop environment is using the amazing
[noctalia-shell](https://github.com/noctalia-dev/noctalia-shell) project.

Theming is present almost everywhere, notably in terminal (Kitty), Firefox and
the desktop UI.

![Screenshot](./screenshots/screenshot-2.png)

There are
[many wallpapers](https://github.com/MachXNU/NixOS-config-files/tree/main/home-manager/desktop/Wallpapers)
to choose from in the wallpaper selector panel (accessible from the control
center).

## Repo organization

Due to the strong requirement of managing several hosts in one config and the
associated constraints (different CPUs, GPUs, headless, etc.)

- In `flake.nix`, all 3 hosts are defined, with a `headless` flag.
- `configuration.nix` is common to all 3 hosts, with some programs being enabled
  or disabled based on this `headless` flag.
- Per-host configs can be found `hosts/hostName`, for example:
  - Nvidia config
  - PCI buses
  - KVM-related boot-args
  - Location of the machine (for the weather app)
- NixOS modules (like KVM, Steam) are defined in `modules/` and imported by
  `programs.nix`
- Home-Manager base configuration is common to all machines. Modules are
  imported based on the `headless` flag
- CLI config like SSH, `git` or shell, are common to all machines (headless or
  not)

## Current status

- Nvidia drivers for my laptop and my desktop
- Modular config for several hosts
- Nice desktop environment
- Basic utilities (zsh, git, SSH, vim...)
- ~~GRUB 2 bootloader~~ (reverted to `systemd-boot` in case of small ESPs)
- Hyprland screen and window sharing (tested with OBS Studio)
- Hyprlock lock screen and hypridle
- Firefox with privacy-oriented config
- Telegram Desktop
- Steam and Proton
- Theming and cool wallpapers
- MicroVMs for Ente on the NAS
- Theme switcher + Wallpaper switcher
- DDNS Updater running on the host with hardened systemd config

## Firefox theming

Theming in Firefox with Noctalia uses
[pywalfox](https://github.com/Frewacom/pywalfox), but
[the default extension](https://addons.mozilla.org/en-US/firefox/addon/pywalfox/)
has settings that are incompatible with Noctalia's color generation scheme.\
One could just change these settings in the extension UI, but **this would not
be declarative**, which is unacceptable...\
As a result, I am rebuilding the extension manually (yes, that was a nightmare
to setup) with patched defaults.

Doing so requires to use Firefox ESR (to disable extensions signinatures), but
this is **not** a security vulnerability, because only approved extensions are
installed, and no other extensions can be added at runtime.

| Light mode                                                 | Dark mode                                                 |
| ---------------------------------------------------------- | --------------------------------------------------------- |
| ![Screenshot](./screenshots/screenshot-pywalfox-light.png) | ![Screenshot](./screenshots/screenshot-pywalfox-dark.png) |

I am aware that, for some reason, theming is not applied after build in Firefox,
and honnestly I don't know why. After a few rebuilds, it seems to work for me.

## Hyprland error message

Just after installation, you will see this error message from Hyprland: that's
because Noctalia hasn't generated colors for it to use yet.

Just change the wallpaper, or toggle dark/light mode. This will trigger a new
color extraction, and Hyprland will find its colors.

![Screenshot](./screenshots/screenshot-hyprland-error.png)

## Noctalia

While Noctalia-shell is indeed a very good project with many amazing features,
some of them do not fit my needs.

- The lock screen looks veyr bad to me, so I decided to reimplement a custom
  lock screen with hyprlock and hypridle, inspired by Style 7 of
  [Hyprlock-Styles](https://github.com/MrVivekRajan/Hyprlock-Styles/)
- The power menu entries are thus overwritten with custom commands to trigger
  hyprlock
- I am not using the IDLE feature, which ends up triggering Noctalia's native
  lock screen, so I have to use hypridle instead.

## TODO

- [ ] Qt theming
- [ ] Better neovim config
- [ ] Discord (fork)
- [ ] Screenshot utility
- [ ] ProtonVPN (either CLI or GTK app)
- [ ] Thunderbird (with Pywalfox config)
- [ ] Idle/Sleep management with `hypridle`
- [ ] Fix Hyprlock's appearance on 16/9 screens

... and probably many more things

## Wallpaper credits

- [Tokyo, Japan by Andre Benz on Unsplash](https://unsplash.com/photos/empty-road-qi2hmCwlhcE)

## VM config

The flake exposes a few VMs that are intended to run on Proxmox in my Homelab.\
They can be built like this:

```bash
nix build .#nixosConfigurations.nixos-vm-xxx.config.system.build.qcow2
```

When secrets are needed, they are decrypted at VM boot by the host via a
hookscript (`secrets/scripts/decrypt-vm-secrets-hook-proxmox.sh`, which calls
`secrets/scripts/decrypt-vm-secrets.sh`), then passed to the VM via a VirtIOFS
mount.

### `nixos-vm-garage`

This VM runs on the Asustor NAS (for now), and it is meant at hosting a s3
bucket for Ente.\
Due to confusing permission issues to access the secrets on the virtio, these
secrets are copied at runtime outside of it, so that Garage can access them.

This VM stores the Garage data on an external disk (currently residing in an
external HDD). The filesystem on this drive has to be an ext4 filesystem with
the correct UUID indicated in the `configuration.nix`.

## On non-NixOS hosts

I need to use a non-NixOS system for work, but I wanted to use my Nix config as
much as possible.\
Fortunately, most of the interesting config is managed by Home Manager, so we
can port that over to a non-NixOS system.

I chose Debian as my Linux distribution for this system.\
The instructions below show how to run my Home Manager config on such a Debian
13 host.

- Perform a clean install of Debian 13
- Login as root and install `sudo`

```bash
apt install sudo
```

- Add the non-priviledged user to the sudo group

```
usermod -aG sudo <username>
```

- Logout from root, and login as the user
- Install `git` and `curl`

```
sudo apt update
sudo apt install git curl
```

- Install Nix, for example via the
  [Determinate Systems](https://determinate.systems/nix-installer/) installer.
- Create an SSH key, add it to your system and to GitHub, then clone this repo

```
git clone git@github.com:MachXNU/NixOS-config-files
```

- Enable flakes:

```bash
mkdir -p ~/.config/nix \
  && grep -qxF "experimental-features = nix-command flakes" ~/.config/nix/nix.conf 2>/dev/null || printf "%s\n" "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

- Run Home Manager from its flake, to install my config:

```bash
nix run github:nix-community/home-manager -- switch --flake .#debian
```

- `home-manager` should now be installed locally. You can switch generations
  with:

```bash
home-manager switch --flake .#debian
```

- Install `nixGL` (if you don't do it now, the next step will prompt you to do
  it)

```bash
nix profile install github:guibou/nixGL --impure
```

- You can try starting Hyprland manually from the TTY with `start-hyprland`. At
  that point, the poweroff/reboot buttons in Noctalia don't work, and Hyprlock
  cannot login. We will fix that just now.

- Install `dconf-service`

```bash
sudo apt install dconf-service
```

- Install a polkit agent:

```bash
sudo apt install polkitd lxpolkit
```

- There are issues with PAM authentication on non-NixOS systems with Nix
  packages, and this prevents our Hyprlock from unlocking. To fix this, first
  create `/etc/pam.d/hyprlock` with the following content:

```
auth required pam_env.so
auth sufficient pam_unix.so try_first_pass likeauth nullok
auth required pam_deny.so

account required pam_unix.so

session required pam_env.so
session required pam_limits.so
session required pam_unix.so
```

- Then, create a persistent wrapper to `unix_chkpwd`. You can find its path with
  `sudo ln -sf /usr/sbin/unix_chkpwd /run/wrappers/bin/unix_chkpwd` and take the
  non-nix-store path. Finally, auto-create the symlink to make it persistent
  across reboots, by creating `/etc/tmpfiles.d/nix-pam.conf` with the following
  content:

```
L /run/wrappers/bin/unix_chkpwd - - - - /usr/sbin/unix_chkpwd
```

- If, like me, you want to disable auto-login at boot, we need install a
  greeter, which will start Hyprland properly. I'm going for `greetd` with
  `tuigreet`

```bash
sudo apt install greetd tuigreet
```

- Configure `greetd` by editing its config file in `/etc/greetd/config.toml` as
  follows:

```bash
[terminal]
vt = 1

[default_session]
command = "tuigreet --cmd 'lxpolkit & dbus-run-session start-hyprland'"
user = "<username>"
```

- Then run:

```bash
sudo systemctl disable getty@tty1.dconf-service
sudo systemctl mask getty@tty1.service
```

- Now, shutdown & reboot buttons in Noctalia should work, and Hyprlock should
  work fine too.
- Set the user's shell to `zsh`:

```bash
echo $(which zsh) | sudo tee -a /etc/shells
chsh -s $(which zsh) $(whoami)
```

- Logout (kill Hyprland with Super+M), login again and check the shell is now
  zsh

## Misc

Remove all the `.backup` files that HM creates before rebuiding:

```bash
find ~/.config -type f -name "*.backup" -delete
```
