#!/bin/bash
# Fuzzy-finder for removing installed pacman packages (native, non-AUR)

fzf_args=(
  --multi
  --with-shell 'bash -c'
  --ansi
  --preview 'pacman -Qi {1} | sed -E '\''s@(https?://[^[:space:]]+)@\x1b[1;36m\1\x1b[0m@g'\'
  --preview-label='alt-p: toggle preview, alt-j/k: scroll, tab: multi-select, ctrl-o: open homepage'
  --preview-label-pos='bottom'
  --preview-window 'down:65%:wrap'
  --bind 'alt-p:toggle-preview'
  --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up'
  --bind 'alt-k:preview-up,alt-j:preview-down'
  --bind 'ctrl-o:execute-silent:u=$(pacman -Qi {1} 2>/dev/null | grep -m1 "^URL" | sed "s/^[^:]*:[[:space:]]*//"); [ -n "$u" ] && [ "$u" != None ] && nohup xdg-open "$u" >/dev/null 2>&1 &'
  --color 'pointer:green,marker:green'
  --header 'Installed Pacman Packages - Select with Tab, Enter to remove'
  --prompt 'Package: '
)

pkg_names=$(pacman -Qqn | fzf "${fzf_args[@]}")

if [[ -n "$pkg_names" ]]; then
  mapfile -t pkgs <<< "$pkg_names"
  sudo pacman -Rns "${pkgs[@]}"

  echo
  read -rp "Done! Press Enter to continue..."
fi
