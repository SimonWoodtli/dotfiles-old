
################################# ARCH ##################################

cleanup() {
  sudo pacman -Rsn $(pacman -Qdtq) # removes orphant packages
  sudo pacman -Sc # removes all uninstalled packages from cache
}

paclog() { tail -n"$1" /var/log/pacman.log ;} # check the log

## list all installed AUR packages
# pacman -Qtm
