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
  # Interrupted downloads leave stray download-XXXXXX temp files behind;
  # pacman -Sc chokes trying to read them as packages, so clear those first.
  while IFS= read -r cache_dir; do
    sudo find "$cache_dir" -maxdepth 1 -name 'download-*' -delete
  done < <(pacman-conf CacheDir)
  sudo pacman -Sc --noconfirm
fi

echo
read -rp "Done! Press Enter to continue..."
