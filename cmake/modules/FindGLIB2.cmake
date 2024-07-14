# https://stackoverflow.com/a/48897168

# Find PkgConfig module
find_package(PkgConfig REQUIRED)

# Use pkg-config to find GLib (glib-2.0)
pkg_search_module(GLIB2 REQUIRED glib-2.0)
