
# 1.0: Introduction

Welcome to **Arch CLI Installer & Manager**, a TUI installer and manager for pacman, AUR, and Flatpak packages on any Arch-based distribution. It's composed of three install programs (`pacfetch`, `aurfetch`, `flatfetch`), three matching management programs (`pacmanage`, `aurmanage`, `flatmanage`), a one-shot updater (`sysupdate`), plus a main menu, `installer`, that ties them all together.

*   **pacfetch:** Fetches packages from the official Arch repositories.
*   **aurfetch:** Fetches packages from the Arch User Repository (AUR).
*   **flatfetch:** Fetches packages from Flathub.
*   **pacmanage:** Removes installed packages from the official Arch repositories.
*   **aurmanage:** Removes installed AUR (foreign) packages.
*   **flatmanage:** Removes installed Flatpak packages.
*   **sysupdate:** Updates pacman, AUR, and Flatpak packages in one pass, then offers to remove orphaned packages and clear the pacman cache.
*   **installer:** Main menu to pick between the three fetchers above, an "Installed packages" submenu to manage what's already installed, or "Update system" to run `sysupdate`; returns to the menu after each action finishes or is cancelled.

In any package list, press `ctrl-o` to open the highlighted package's page in your default browser, via `xdg-open` (its homepage for pacman, its AUR page for AUR packages, its Flathub page for Flatpaks). URLs shown in the preview pane are also highlighted so they're easy to spot.

# 1.1: Installation

### Build and install locally

The PKGBUILD builds directly from this repository's sources, so cloning and running `makepkg -si` always gets you the full `installer` menu shown above:

~~~bash
git clone https://github.com/UncleClaude/Arch-CLI-Installer-Manager.git
cd Arch-CLI-Installer-Manager
makepkg -si
~~~

The PKGBUILD declares `provides`/`conflicts`/`replaces` for the project's earlier names (`omarchy-installers`, `archie`), so if you have either of those installed, pacman replaces it automatically during install — no manual removal step needed.

### Update in place

Once installed, pull the latest changes and rebuild the same way:

~~~bash
cd Arch-CLI-Installer-Manager
git pull
makepkg -si
~~~

# 1.2: Credits

Arch CLI Installer & Manager began as a fork of [kantiankant/Omarchy_installers](https://github.com/kantiankant/Omarchy_installers), which first ported Omarchy's `pacfetch`/`aurfetch` TUI wrappers to other Arch-based distros and was packaged on the AUR by Tony Tan. That original work is the foundation this project is built on. It has since grown into its own project: a redesigned main menu, `flatfetch`, and a full "Installed packages" management suite (`pacmanage`/`aurmanage`/`flatmanage`).
