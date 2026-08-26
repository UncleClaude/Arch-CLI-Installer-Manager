#!/bin/bash
# Updates pacman, AUR, and Flatpak packages in one pass

if command -v yay &>/dev/null; then
  # yay -Syu updates official repo and AUR packages together, avoiding the
  # partial-upgrade issues of syncing them separately.
  yay -Syu
else
  sudo pacman -Syu
fi

if command -v flatpak &>/dev/null; then
  flatpak update -y
fi

echo
gum spin --spinner "globe" --title "Done! Press any key to close..." -- bash -c 'read -n 1 -s'
