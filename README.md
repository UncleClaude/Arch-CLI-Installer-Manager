
# 1.0: Introduction

Welcome to **omarchy-installers**. This package is composed of three install programs (`pacfetch`, `aurfetch`, `flatfetch`), three matching management programs (`pacmanage`, `aurmanage`, `flatmanage`), plus a main menu, `installer`, that ties them all together. These programs are ports of the TUI wrappers Omarchy uses for package installation, but now for every other Arch-based distribution.

*   **pacfetch:** Fetches packages from the official Arch repositories.
*   **aurfetch:** Fetches packages from the Arch User Repository (AUR).
*   **flatfetch:** Fetches packages from Flathub.
*   **pacmanage:** Removes installed packages from the official Arch repositories.
*   **aurmanage:** Removes installed AUR (foreign) packages.
*   **flatmanage:** Removes installed Flatpak packages.
*   **installer:** Main menu to pick between the three fetchers above, or an "Installed packages" submenu to manage what's already installed; returns to the menu after each action finishes or is cancelled.

# 1.1: Installation

### Build and install locally (recommended)

The PKGBUILD builds directly from this repository's sources, so cloning and running `makepkg -si` always gets you the `installer` menu and `flatfetch` shown above.

~~~bash
git clone https://github.com/UncleClaude/Omarchy_installers.git
cd Omarchy_installers
makepkg -si
~~~

### AUR (may be out of date)

`omarchy-installers` is also published on the AUR, tracking the original upstream repository. That package may not include the `installer` menu or `flatfetch` yet:

~~~bash
yay -S omarchy-installers
# OR
paru -S omarchy-installers
~~~

# 1.2: Credits

This is a fork of [kantiankant/Omarchy_installers](https://github.com/kantiankant/Omarchy_installers), which ported Omarchy's `pacfetch`/`aurfetch` TUI wrappers to other Arch-based distros and is packaged on the AUR by Tony Tan. This fork builds on that original work, adding the `installer` main menu and `flatfetch`.

