#!/bin/bash
# Fuzzy-finder for removing installed Flatpak packages

fzf_args=(
  --multi
  --with-shell 'bash -c'
  --delimiter '\t'
  --with-nth '2,3'
  --ansi
  --preview '{ flatpak info {1} 2>/dev/null; printf "\nFlathub: https://flathub.org/apps/%s\n" {1}; } | sed -E '\''s@(https?://[^[:space:]]+)@\x1b[1;36m\1\x1b[0m@g'\'
  --preview-label='alt-p: toggle preview, alt-j/k: scroll, tab: multi-select, ctrl-o: open Flathub page'
  --preview-label-pos='bottom'
  --preview-window 'down:65%:wrap'
  --bind 'alt-p:toggle-preview'
  --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up'
  --bind 'alt-k:preview-up,alt-j:preview-down'
  --bind 'ctrl-o:execute-silent:nohup xdg-open https://flathub.org/apps/{1} >/dev/null 2>&1 &'
  --color 'pointer:green,marker:green'
  --header 'Installed Flatpak Packages - Select with Tab, Enter to remove'
  --prompt 'Package: '
)

if ! command -v flatpak &>/dev/null; then
  echo "Error: flatpak not found."
  exit 1
fi

pkg_ids=$(flatpak list --app --columns=application,name,description | fzf "${fzf_args[@]}" | cut -f1)

if [[ -n "$pkg_ids" ]]; then
  mapfile -t pkgs <<< "$pkg_ids"
  flatpak uninstall -y "${pkgs[@]}"

  echo
  read -rp "Done! Press Enter to continue..."
fi
