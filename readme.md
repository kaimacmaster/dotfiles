# Kai Macmaster's Dotfiles

This is a collection of my dotfiles. I use these to configure my system to my liking.

These dotfiles are specific to my system and may not work on your system. However, you are welcome to use them as a reference or a starting point for your own dotfiles.

## Installation

To install these dotfiles, clone this repository to your home directory:

```bash
git clone
```

Then run the install script:

```bash
./install.sh
```

This will create symlinks to the dotfiles in your home directory.

## Just some useful Linux commands

These are some useful Linux commands that I use frequently when setting up a new system. I have included them here for reference.

### Gaming Tweaks

Enable touchpad while typing:

```bash
gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing false
```

### System Tweaks

Use the new gnome scaling method (requires gnome 47) for allowing x11 apps to scale natively on wayland:

```bash
gsettings set org.gnome.mutter experimental-features '["scale-monitor-framebuffer", "xwayland-native-scaling"]' 
```

Copy the monitor resolution and scaling configuration to GDM:

```bash
sudo cp ~/.config/monitors.xml /var/lib/gdm3/.config/
```

### Ubuntu Specific Tweaks

Disable the dock's intellihide feature so it actually auto hides instead of just moving out of the way:

```bash
gsettings set org.gnome.shell.extensions.dash-to-dock intellihide false
```

### Fedora Specific Tweaks

Set the default dnf response to yes:

```bash
sudo dnf config-manager --setopt=dnf.yes=True
```

### Git Tweaks

Set the default git editor to nvim:

```bash
git config --global core.editor nvim
```

Set the git user name and email:

```bash
git config --global user.name "Kai Macmaster"
git config --global user.email "kai@macmaster.co.uk"
```
