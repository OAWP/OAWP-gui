#!/bin/sh

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"

INFO="["$BLUE"i"$ENDCOLOR"]"
WARN="["$YELLOW"w"$ENDCOLOR"]"
ERR="["$RED"e"$ENDCOLOR"]"

# Check for root
if [ "$EUID" -ne 0 ]; then
  printf "$ERR Please run this script with super user permission!\n"
  exit 1
fi

# Basic global variables
PKG_MGR=""          # The package manager that will install the dependencies
WILL_INSTALL=false  # Check if anything will be installed, else skip

# List of dependencies
# Common Linux: gcc make libconfig gtk3 glib2
# Debian:       gcc make libconfig-dev libgtk-3-dev libglib2.0-dev
# RHEL:         gcc make libconfig-devel gtk3-devel glib2-devel
# BSD:          gcc gmake libconfig gtk3 devel/glib20

# Checking existing dependencies
if [ ! -x "$(command -v gcc)" ]; then
  printf "$INFO ${GREEN}gcc${ENDCOLOR} not detected, adding it in the dependencies install queue\n"
  DEPENDENCIES="$DEPENDENCIES gcc"
  DEB_DEPENDENCIES="$DEB_DEPENDENCIES gcc"
  RPM_DEPENDENCIES="$RPM_DEPENDENCIES gcc"
  BSD_DEPENDENCIES="$BSD_DEPENDENCIES gcc"
  WILL_INSTALL=true
fi

if [ ! -x "$(command -v make)" ]; then
  printf "$INFO ${GREEN}make${ENDCOLOR} not detected, adding it in the dependencies install queue\n"
  DEPENDENCIES="$DEPENDENCIES make"
  DEB_DEPENDENCIES="$DEB_DEPENDENCIES make"
  RPM_DEPENDENCIES="$RPM_DEPENDENCIES make"
  BSD_DEPENDENCIES="$BSD_DEPENDENCIES gmake"
  WILL_INSTALL=true
fi

if [ ! -f "/usr/include/libconfig.h" ]; then
  printf "$INFO ${GREEN}libconfig${ENDCOLOR} not detected, adding it in the dependencies install queue\n"
  DEPENDENCIES="$DEPENDENCIES libconfig"
  DEB_DEPENDENCIES="$DEB_DEPENDENCIES libconfig-dev"
  RPM_DEPENDENCIES="$RPM_DEPENDENCIES libconfig-devel"
  BSD_DEPENDENCIES="$BSD_DEPENDENCIES libconfig"
  WILL_INSTALL=true
fi

if [ ! -f "/usr/include/gtk-3.0/gtk/gtk.h" ]; then
  printf "$INFO ${GREEN}gtk${ENDCOLOR} not detected, adding it in the dependencies install queue\n"
  DEPENDENCIES="$DEPENDENCIES gtk3"
  DEB_DEPENDENCIES="$DEB_DEPENDENCIES libgtk-3-dev"
  RPM_DEPENDENCIES="$RPM_DEPENDENCIES gtk3-devel"
  BSD_DEPENDENCIES="$BSD_DEPENDENCIES gtk3"
  WILL_INSTALL=true
fi

if [ ! -f "/usr/include/glib-2.0/glib.h" ]; then
  printf "$INFO ${GREEN}glib${ENDCOLOR} not detected, adding it in the dependencies install queue\n"
  DEPENDENCIES="$DEPENDENCIES glib2"
  DEB_DEPENDENCIES="$DEB_DEPENDENCIES libglib2.0-dev"
  RPM_DEPENDENCIES="$RPM_DEPENDENCIES glib2-devel"
  BSD_DEPENDENCIES="$BSD_DEPENDENCIES devel/glib20"
  WILL_INSTALL=true
fi

# Choosing the right package manager
## Linux distributions
if [ "$WILL_INSTALL" = "true" ]; then
  ### Debian
  if [ -x "$(command -v apt-get)" ]; then
    printf "$INFO apt-get package manager detected\n"
    PKG_MGR="apt-get"

  ### Arch
  elif [ -x "$(command -v pacman)" ]; then
    printf "$INFO pacman package manager detected\n"
    PKG_MGR="pacman"

  ### Fedora
  elif [ -x "$(command -v dnf)" ]; then
    printf "$INFO dnf package manager detected\n"
    PKG_MGR="dnf"

  ### CentOS
  elif [ -x "$(command -v yum)" ]; then
    printf "$INFO yum package manager detected\n"
    PKG_MGR="yum"

  ### Gentoo
  elif [ -x "$(command -v emerge)" ]; then
    printf "$ERR Portage detected!\n\
$ERR Automatic package instalation with portage may lead to package conflicts.\n\
$ERR Please install$DEPENDENCIES manually and run this file again to compile and install XAWP in your system!\n\
$ERR To install these dependencies, try \"sudo emerge --ask $DEPENDENCIES\".\n
$ERR For more info, see https://wiki.gentoo.org/wiki/Emerge and https://wiki.gentoo.org/wiki/Portage\n"
    exit 1

  ## BSD Family
  ### FreeBSD
  elif [ -x "$(command -v pkg)" ]; then
    printf "$INFO pkg package manager detected\n"
    PKG_MGR="pkg"

  ### OpenBSD
  elif [ -x "$(command -v pkg_add)" ]; then
    printf "$INFO pkg_add detected\n"
    printf "$WARN If you are using OpenBSD, you might not have a good desktop experience because of OpenBSD's lack of graphics drivers support for nVidia GPUs.\n"
    PKG_MGR="pkg_add"

  ### NetBSD
  elif [ -x "$(command -v pkgin)" ]; then
    printf "$INFO pkgin package manager detected\n"
    PKG_MGR="pkgin"

  ### No package manager
  else
    printf "$ERR A valid package manager was not found!\n\
  $ERR Please install$DEPENDENCIES manually and run this file again to compile and install XAWP in your system!\n"
    exit 1
  fi

  printf "$INFO $PKG_MGR will install the required dependencies\n"
  # Install dependencies
  ## Debian
  if [ $PKG_MGR = "apt-get" ]; then
    $PKG_MGR install -y $DEB_DEPENDENCIES
  ## Arch
  elif [ $PKG_MGR = "pacman" ]; then
    $PKG_MGR -Sy --noconfirm $DEPENDENCIES
  ## RedHat
  elif [ $PKG_MGR = "dnf" ]; then
    $PKG_MGR install -y $RPM_DEPENDENCIES
  ## CentOS
  elif [ $PKG_MGR = "yum" ]; then
    $PKG_MGR -y install $RPM_DEPENDENCIES
  ## FreeBSD
  elif [ $PKG_MGR = "pkg" ]; then
    $PKG_MGR install -y $BSD_DEPENDENCIES
  ## OpenBSD
  elif [ $PKG_MGR = "pkg_add" ]; then
    $PKG_MGR $BSD_DEPENDENCIES
  ## NetBSD
  elif [ $PKG_MGR = "pkgin" ]; then
    $PKG_MGR -y install $BSD_DEPENDENCIES
  fi
  EXIT_CODE=$?
  if [ $EXIT_CODE -eq 0 ]; then
    printf "$INFO Packages installed successfully\n"
  else
    printf "$ERR Error: $PKG_MGR returned with exit code $EXIT_CODE, aborting!\n"
    exit 1
  fi

else
  printf "$INFO Nothing to install, skipping configure.sh\n"
fi
