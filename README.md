
# 1.0: Introduction

Welcome to **omarchy-installers**. This package is composed of three programs: `pacfetch`, `aurfetch`, and `flatfetch`, plus a main menu, `installer`, that ties them together. These programs are ports of the TUI wrappers Omarchy uses for package installation, but now for every other Arch-based distribution.

*   **pacfetch:** Fetches packages from the official Arch repositories.
*   **aurfetch:** Fetches packages from the Arch User Repository (AUR).
*   **flatfetch:** Fetches packages from Flathub.
*   **installer:** Main menu to pick between the three above; returns to the menu after each one finishes or is cancelled.

# 1.1: Installation

### Automatic installation (From the AUR):

~~~bash
yay -S omarchy-installers
# OR
paru -S omarchy-installers
~~~

### Manual installation

Clone the repository, change your working directory to it, and run makepkg -si.

~~~bash
git clone https://github.com/kantiankant/Omarchy_installers.git  
cd omarchy-installers
makepkg -si
~~~

