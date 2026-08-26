#!/bin/bash
# AUR installer using yay because paru has decided to communicate exclusively in binary

fzf_args=(
  --multi
  --with-shell 'bash -c'
  --ansi
  --preview 'yay -Siia {1} | sed -E '\''s@(https?://[^[:space:]]+)@\x1b[1;36m\1\x1b[0m@g'\'
  --preview-label='alt-p: toggle preview, alt-b/B: toggle PKGBUILD, alt-j/k: scroll, tab: multi-select, ctrl-o: open AUR page'
  --preview-label-pos='bottom'
  --preview-window 'down:65%:wrap'
  --bind 'alt-p:toggle-preview'
  --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up'
  --bind 'alt-k:preview-up,alt-j:preview-down'
  --bind 'alt-b:change-preview:yay -Gpa {1} | tail -n +5'
  --bind 'alt-B:change-preview:yay -Siia {1} | sed -E '\''s@(https?://[^[:space:]]+)@\x1b[1;36m\1\x1b[0m@g'\'
  --bind 'ctrl-o:execute-silent:nohup xdg-open https://aur.archlinux.org/packages/{1} >/dev/null 2>&1 &'
  --color 'pointer:green,marker:green'
  --header 'AUR Package Installer - Select with Tab, Enter to install'
  --prompt 'Package: '
)

if ! command -v yay &>/dev/null; then
  echo "Error: yay not found."
  exit 1
fi

pkg_names=$(yay -Slqa | fzf "${fzf_args[@]}")

if [[ -n "$pkg_names" ]]; then
  mapfile -t pkgs <<< "$pkg_names"
  yay -S "${pkgs[@]}"

  if command -v updatedb &>/dev/null; then
    sudo updatedb &
  fi

  echo
  read -rp "Done! Press Enter to continue..."
fi
