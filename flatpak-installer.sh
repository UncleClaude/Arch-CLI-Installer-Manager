#!/bin/bash
# Fuzzy-finder for installing Flatpak packages from Flathub

fzf_args=(
  --multi
  --delimiter '\t'
  --with-nth '2,3'
  --preview 'flatpak remote-info flathub {1} 2>/dev/null'
  --preview-label='alt-p: toggle preview, alt-j/k: scroll, tab: multi-select'
  --preview-label-pos='bottom'
  --preview-window 'down:65%:wrap'
  --bind 'alt-p:toggle-preview'
  --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up'
  --bind 'alt-k:preview-up,alt-j:preview-down'
  --color 'pointer:green,marker:green'
  --header 'Flatpak Installer (Flathub) - Select with Tab, Enter to install'
  --prompt 'Package: '
)

if ! command -v flatpak &>/dev/null; then
  echo "Error: flatpak not found."
  exit 1
fi

if ! flatpak remote-list | grep -q '^flathub'; then
  echo "Error: flathub remote not found."
  echo "Add it with: flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo"
  exit 1
fi

pkg_ids=$(flatpak remote-ls flathub --columns=application,name,description | fzf "${fzf_args[@]}" | cut -f1)

if [[ -n "$pkg_ids" ]]; then
  echo "$pkg_ids" | tr '\n' ' ' | xargs flatpak install -y flathub

  echo
  gum spin --spinner "globe" --title "Done! Press any key to close..." -- bash -c 'read -n 1 -s'
fi
