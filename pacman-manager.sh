#!/bin/bash
# Fuzzy-finder for removing installed pacman packages (native, non-AUR)

fzf_args=(
  --multi
  --preview 'pacman -Qi {1}'
  --preview-label='alt-p: toggle preview, alt-j/k: scroll, tab: multi-select'
  --preview-label-pos='bottom'
  --preview-window 'down:65%:wrap'
  --bind 'alt-p:toggle-preview'
  --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up'
  --bind 'alt-k:preview-up,alt-j:preview-down'
  --color 'pointer:green,marker:green'
  --header 'Installed Pacman Packages - Select with Tab, Enter to remove'
  --prompt 'Package: '
)

pkg_names=$(pacman -Qqn | fzf "${fzf_args[@]}")

if [[ -n "$pkg_names" ]]; then
  mapfile -t pkgs <<< "$pkg_names"
  sudo pacman -Rns "${pkgs[@]}"

  echo
  gum spin --spinner "globe" --title "Done! Press any key to close..." -- bash -c 'read -n 1 -s'
fi
