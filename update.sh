#!/bin/bash
# Updates pacman, AUR, and Flatpak packages, then offers to remove orphaned
# packages and clear the pacman cache

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
mapfile -t orphans < <(pacman -Qtdq 2>/dev/null)
if [[ ${#orphans[@]} -gt 0 ]]; then
  echo "Orphaned packages:"
  printf '  %s\n' "${orphans[@]}"
  if gum confirm "Remove ${#orphans[@]} orphaned package(s)?"; then
    sudo pacman -Rns --noconfirm "${orphans[@]}"
  fi
fi

echo
if gum confirm "Clear the pacman cache of uninstalled packages?"; then
  sudo pacman -Sc --noconfirm
fi

echo
gum spin --spinner "globe" --title "Done! Press any key to close..." -- bash -c 'read -n 1 -s'
