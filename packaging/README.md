# Flatpak Bundle Packaging

This creates a Flatpak bundle for Foliate 自用版 that can be installed on Ubuntu, Manjaro, and other Linux distributions with Flatpak support.

## Install Packaging Tools

Ubuntu:

```sh
sudo apt install flatpak flatpak-builder
```

Manjaro:

```sh
sudo pacman -S flatpak flatpak-builder
```

## Build the Bundle

From the project root:

```sh
./packaging/build-flatpak-bundle.sh
```

If Flathub is slow in your region, point the script at a mirror:

```sh
FLATHUB_REMOTE=flathub-mirror \
FLATHUB_REPO=https://mirror.sjtu.edu.cn/flathub/flathub.flatpakrepo \
./packaging/build-flatpak-bundle.sh
```

If you have a local proxy:

```sh
PACKAGING_PROXY=127.0.0.1:10808 ./packaging/build-flatpak-bundle.sh
```

The bundle will be written to:

```sh
dist/io.github.misakisata.Foliate.flatpak
```

## Install and Run

```sh
flatpak install --user dist/io.github.misakisata.Foliate.flatpak
flatpak run io.github.misakisata.Foliate
```

To install system-wide, omit `--user`.
