#!/bin/bash
# Fuzzy-finder for installing packages from pacman repos (including CachyOS repos)

fzf_args=(
  --multi
  --with-shell 'bash -c'
  --ansi
  --preview 'pacman -Si {1} 2>/dev/null | sed -E '\''s@(https?://[^[:space:]]+)@\x1b[1;36m\1\x1b[0m@g'\'
  --preview-label='alt-p: toggle preview, alt-j/k: scroll, tab: multi-select, ctrl-o: open homepage'
  --preview-label-pos='bottom'
  --preview-window 'down:65%:wrap'
  --bind 'alt-p:toggle-preview'
  --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up'
  --bind 'alt-k:preview-up,alt-j:preview-down'
  --bind 'ctrl-o:execute-silent:u=$(pacman -Si {1} 2>/dev/null | grep -m1 "^URL" | sed "s/^[^:]*:[[:space:]]*//"); [ -n "$u" ] && [ "$u" != None ] && nohup xdg-open "$u" >/dev/null 2>&1 &'
  --color 'pointer:green,marker:green'
  --header 'Package Installer - Select with Tab, Enter to install'
  --prompt 'Package: '
)

pkg_names=$(pacman -Slq | fzf "${fzf_args[@]}")

if [[ -n "$pkg_names" ]]; then
  echo "$pkg_names" | tr '\n' ' ' | xargs sudo pacman -S --noconfirm

  # Update locate database in the background
  if command -v updatedb &>/dev/null; then
    sudo updatedb &
  fi

  echo
  gum spin --spinner "globe" --title "Done! Press any key to close..." -- bash -c 'read -n 1 -s'
fi
