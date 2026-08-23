#!/bin/bash
# Main menu for the Omarchy installers - pick a package source, run it, and
# land back here when it finishes (or gets cancelled).

fzf_args=(
  --no-multi
  --color 'pointer:green,marker:green'
  --header 'Omarchy Installers - Select a package source'
  --prompt 'Select: '
)

manage_fzf_args=(
  --no-multi
  --color 'pointer:green,marker:green'
  --header 'Installed Packages - Select a package source'
  --prompt 'Select: '
)

manage_menu() {
  while true; do
    choice=$(printf '%s\n' \
      'Pacman   (pacmanage)  - Official Arch repositories' \
      'AUR      (aurmanage)  - Arch User Repository' \
      'Flatpak  (flatmanage) - Flathub' \
      'Back' | fzf "${manage_fzf_args[@]}")

    case "$choice" in
      Pacman*)
        pacmanage
        ;;
      AUR*)
        aurmanage
        ;;
      Flatpak*)
        flatmanage
        ;;
      Back* | "")
        return
        ;;
    esac
  done
}

while true; do
  choice=$(printf '%s\n' \
    'Pacman             (pacfetch)   - Official Arch repositories' \
    'AUR                (aurfetch)   - Arch User Repository' \
    'Flatpak            (flatfetch)  - Flathub' \
    'Installed packages - Manage what is already installed' \
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
    Installed*)
      manage_menu
      ;;
    Quit* | "")
      exit 0
      ;;
  esac
done
