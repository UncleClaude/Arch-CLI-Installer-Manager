#!/bin/bash
# Main menu for the Omarchy installers - pick a package source, run it, and
# land back here when it finishes (or gets cancelled).

fzf_args=(
  --no-multi
  --color 'pointer:green,marker:green'
  --header 'Omarchy Installers - Select a package source'
  --prompt 'Select: '
)

while true; do
  choice=$(printf '%s\n' \
    'Pacman   (pacfetch)   - Official Arch repositories' \
    'AUR      (aurfetch)   - Arch User Repository' \
    'Flatpak  (flatfetch)  - Flathub' \
    'Quit' | fzf "${fzf_args[@]}")

  case "$choice" in
    Pacman*)
      pacfetch
      ;;
    AUR*)
      aurfetch
      ;;
    Flatpak*)
      flatfetch
      ;;
    Quit* | "")
      exit 0
      ;;
  esac
done
