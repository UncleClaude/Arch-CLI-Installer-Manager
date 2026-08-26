#!/bin/bash
# Fuzzy-finder for installing Flatpak packages from Flathub

fzf_args=(
  --multi
  --with-shell 'bash -c'
  --delimiter '\t'
  --with-nth '2,3'
  --ansi
  --preview '{ flatpak remote-info flathub {1} 2>/dev/null; printf "\nFlathub: https://flathub.org/apps/%s\n" {1}; } | sed -E '\''s@(https?://[^[:space:]]+)@\x1b[1;36m\1\x1b[0m@g'\'
  --preview-label='alt-p: toggle preview, alt-j/k: scroll, tab: multi-select, ctrl-o: open Flathub page'
  --preview-label-pos='bottom'
  --preview-window 'down:65%:wrap'
  --bind 'alt-p:toggle-preview'
  --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up'
  --bind 'alt-k:preview-up,alt-j:preview-down'
  --bind 'ctrl-o:execute-silent:nohup xdg-open https://flathub.org/apps/{1} >/dev/null 2>&1 &'
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
  flathub_repo_url="https://dl.flathub.org/repo/flathub.flatpakrepo"
  printf 'Add it with: flatpak remote-add --if-not-exists flathub \e]8;;%s\e\\%s\e]8;;\e\\\n' "$flathub_repo_url" "$flathub_repo_url"
  exit 1
fi

pkg_ids=$(flatpak remote-ls flathub --columns=application,name,description | fzf "${fzf_args[@]}" | cut -f1)

if [[ -n "$pkg_ids" ]]; then
  echo "$pkg_ids" | tr '\n' ' ' | xargs flatpak install -y flathub

  echo
  gum spin --spinner "globe" --title "Done! Press any key to close..." -- bash -c 'read -n 1 -s'
fi
