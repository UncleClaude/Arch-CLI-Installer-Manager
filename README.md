
# 1.0: Introduction

Welcome to **Archie**, a TUI installer and manager for pacman, AUR, and Flatpak packages on any Arch-based distribution. It's composed of three install programs (`pacfetch`, `aurfetch`, `flatfetch`), three matching management programs (`pacmanage`, `aurmanage`, `flatmanage`), plus a main menu, `installer`, that ties them all together.

*   **pacfetch:** Fetches packages from the official Arch repositories.
*   **aurfetch:** Fetches packages from the Arch User Repository (AUR).
*   **flatfetch:** Fetches packages from Flathub.
*   **pacmanage:** Removes installed packages from the official Arch repositories.
*   **aurmanage:** Removes installed AUR (foreign) packages.
*   **flatmanage:** Removes installed Flatpak packages.
*   **installer:** Main menu to pick between the three fetchers above, or an "Installed packages" submenu to manage what's already installed; returns to the menu after each action finishes or is cancelled.

# 1.1: Installation

### Build and install locally (recommended)

The PKGBUILD builds directly from this repository's sources, so cloning and running `makepkg -si` always gets you the full `installer` menu shown above.

~~~bash
git clone https://github.com/UncleClaude/Archie.git
cd Archie
makepkg -si
~~~

# 1.2: Credits

Archie began as a fork of [kantiankant/Omarchy_installers](https://github.com/kantiankant/Omarchy_installers), which first ported Omarchy's `pacfetch`/`aurfetch` TUI wrappers to other Arch-based distros and was packaged on the AUR by Tony Tan. That original work is the foundation this project is built on. Archie has since grown into its own project: a redesigned main menu, `flatfetch`, and a full "Installed packages" management suite (`pacmanage`/`aurmanage`/`flatmanage`).
