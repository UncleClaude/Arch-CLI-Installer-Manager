# Maintainer: Tony Tan <qwerasdnoob@gmail.com>
pkgname=omarchy-installers
pkgver=1.0.0
pkgrel=5
pkgdesc="A port of Omarchy's AUR, pacman, and Flatpak package installers for Arch-based distros"
arch=('any')
url="https://github.com/kantiankant/Omarchy_installers"
license=('GPL3')
depends=('fzf' 'pacman')
optdepends=(
  'yay: for AUR package installation'
  'flatpak: for Flatpak package installation'
  'mlocate: for updating the locate database after installation'
)

package() {
  cd "${startdir}"

  install -Dm755 aur-installer.sh "${pkgdir}/usr/bin/aurfetch"
  install -Dm755 pacman-installer.sh "${pkgdir}/usr/bin/pacfetch"
  install -Dm755 flatpak-installer.sh "${pkgdir}/usr/bin/flatfetch"
  install -Dm755 aur-manager.sh "${pkgdir}/usr/bin/aurmanage"
  install -Dm755 pacman-manager.sh "${pkgdir}/usr/bin/pacmanage"
  install -Dm755 flatpak-manager.sh "${pkgdir}/usr/bin/flatmanage"
  install -Dm755 installer.sh "${pkgdir}/usr/bin/installer"
}
