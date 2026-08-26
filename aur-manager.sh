#!/bin/bash
# Fuzzy-finder for removing installed AUR (foreign) packages

fzf_args=(
  --multi
  --preview 'pacman -Qi {1} | sed -E '\''s@(https?://[^[:space:]]+)@\x1b]8;;\1\x1b\\\1\x1b]8;;\x1b\\@g'\'
  --preview-label='alt-p: toggle preview, alt-j/k: scroll, tab: multi-select, ctrl-o: open homepage'
  --preview-label-pos='bottom'
  --preview-window 'down:65%:wrap'
  --bind 'alt-p:toggle-preview'
  --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up'
  --bind 'alt-k:preview-up,alt-j:preview-down'
  --bind 'ctrl-o:execute-silent:u=$(pacman -Qi {1} 2>/dev/null | grep -m1 "^URL" | sed "s/^[^:]*:[[:space:]]*//"); [ -n "$u" ] && [ "$u" != None ] && nohup xdg-open "$u" >/dev/null 2>&1 &'
  --color 'pointer:green,marker:green'
  --header 'Installed AUR Packages - Select with Tab, Enter to remove'
  --prompt 'Package: '
)

pkg_names=$(pacman -Qqm | fzf "${fzf_args[@]}")

if [[ -n "$pkg_names" ]]; then
  mapfile -t pkgs <<< "$pkg_names"
  sudo pacman -Rns "${pkgs[@]}"

  echo
  gum spin --spinner "globe" --title "Done! Press any key to close..." -- bash -c 'read -n 1 -s'
fi
