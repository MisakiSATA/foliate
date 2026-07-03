#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP_ID="io.github.misakisata.Foliate"
RUNTIME_VERSION="49"
FLATHUB_REMOTE="${FLATHUB_REMOTE:-flathub}"
FLATHUB_REPO="${FLATHUB_REPO:-https://flathub.org/repo/flathub.flatpakrepo}"
PACKAGING_PROXY="${PACKAGING_PROXY:-}"
MANIFEST="$ROOT/packaging/flatpak-local.json"
BUILD_DIR="$ROOT/.flatpak-build"
REPO_DIR="$ROOT/dist/flatpak-repo"
BUNDLE="$ROOT/dist/${APP_ID}.flatpak"

if ! command -v flatpak >/dev/null 2>&1; then
    echo "flatpak is required. Install it with apt or pacman first." >&2
    exit 1
fi

if ! command -v flatpak-builder >/dev/null 2>&1; then
    echo "flatpak-builder is required. Install it with apt or pacman first." >&2
    exit 1
fi

cd "$ROOT"
git submodule update --init --recursive

if [[ -n "$PACKAGING_PROXY" ]]; then
    case "$PACKAGING_PROXY" in
        *://*) PROXY_URL="$PACKAGING_PROXY" ;;
        *) PROXY_URL="http://$PACKAGING_PROXY" ;;
    esac
    export http_proxy="$PROXY_URL"
    export https_proxy="$PROXY_URL"
    export all_proxy="$PROXY_URL"
    export HTTP_PROXY="$PROXY_URL"
    export HTTPS_PROXY="$PROXY_URL"
    export ALL_PROXY="$PROXY_URL"
fi

flatpak remote-add --user --if-not-exists "$FLATHUB_REMOTE" "$FLATHUB_REPO"
flatpak install --user -y "$FLATHUB_REMOTE" \
    "org.gnome.Platform//$RUNTIME_VERSION" \
    "org.gnome.Sdk//$RUNTIME_VERSION"

rm -rf "$BUILD_DIR" "$REPO_DIR" "$BUNDLE"
mkdir -p "$ROOT/dist"

flatpak-builder \
    --user \
    --force-clean \
    --install-deps-from="$FLATHUB_REMOTE" \
    --repo="$REPO_DIR" \
    "$BUILD_DIR" \
    "$MANIFEST"

flatpak build-bundle "$REPO_DIR" "$BUNDLE" "$APP_ID"

echo "Created $BUNDLE"
echo "Install with: flatpak install --user $BUNDLE"
echo "Run with: flatpak run $APP_ID"
