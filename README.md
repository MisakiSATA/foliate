<img src="data/io.github.misakisata.Foliate.svg" align="left" style="margin-right:8px">
<br><br>

# Foliate 自用版

个人使用的 Foliate 构建，默认中文界面，使用独立应用 ID：`io.github.misakisata.Foliate`。

![Screenshot](data/screenshots/screenshot.png)

## 安装和使用

### 推荐方式：Flatpak

这个自用版使用独立应用 ID `io.github.misakisata.Foliate` 和命令 `foliate-personal`，不会覆盖官方 Foliate。

Ubuntu:

```sh
sudo apt install flatpak flatpak-builder
```

Manjaro:

```sh
sudo pacman -S flatpak flatpak-builder
```

打包、安装和运行：

```sh
./packaging/build-flatpak-bundle.sh
flatpak install --user dist/io.github.misakisata.Foliate.flatpak
flatpak run io.github.misakisata.Foliate
```

如果下载 Flathub 依赖很慢，可以使用本地代理：

```sh
PACKAGING_PROXY=127.0.0.1:10808 ./packaging/build-flatpak-bundle.sh
```

更多说明见 [packaging/README.md](packaging/README.md)。

### 源码运行依赖

- `gjs` (>= 1.82)
- `gtk4` (>= 4.12)
- `libadwaita` (>= 1.8; Debian/Ubuntu 中通常是 `gir1.2-adw-1`)
- `webkitgtk-6.0` (Fedora 中通常是 `webkitgtk6.0`，Debian/Ubuntu 中通常是 `gir1.2-webkit-6.0`)

#### 可选依赖

自动断词需要安装对应语言的 hyphenation rules，例如 `hyphen-en`、`hyphen-fr`。

文本转语音需要安装 `speech-dispatcher` 和 `espeak-ng` 等输出模块。

如果安装了 `tracker` (>= 3) 和 `tracker-miners`，资料库视图可以跟踪文件位置。

### 获取源码

The repo uses git submodules. Before running or installing, make sure you clone the whole thing with `--recurse-submodules`:

```
git clone --recurse-submodules https://github.com/MisakiSATA/foliate.git
```

### 不安装直接运行

It's possible to run directly from the source tree without building or installing. Simply run

```
gjs -m src/main.js
```

This can be useful if you just want to quickly try out Foliate or test a change.

But note that this will run it without using GSettings, so settings will not be saved. To solve this, you can compile the schema by running

```
glib-compile-schemas data
```

Then you can set the schema directory when running the app:

```
GSETTINGS_SCHEMA_DIR=data gjs -m src/main.js
```

### 从源码构建安装

The following dependencies are required for building:

- `meson` (>= 0.59)
- `pkg-config`
- `gettext`

To install, run the following commands:

```
meson setup build
sudo ninja -C build install
```

To uninstall, run

```
sudo ninja -C build uninstall
```

#### Installing to a Local Directory

By default Meson installs to `/usr/local`. You can install without root permissions by choosing a local prefix, such as `$PWD/run`:

```
meson setup build --prefix $PWD/run
ninja -C build install
```

You can then run it with

```
GSETTINGS_SCHEMA_DIR=run/share/glib-2.0/schemas ./run/bin/foliate-personal
```

## Screenshots

![Dark mode](data/screenshots/dark.png)

![Wikipedia lookup](data/screenshots/lookup.png)

![Book metadata](data/screenshots/about.png)

![Annotations](data/screenshots/annotations.png)

![Popup footnote](data/screenshots/footnote.png)

![Vertical writing](data/screenshots/vertical.png)

## License

This program is free software: you can redistribute it and/or modify it under the terms of the [GNU General Public License](https://www.gnu.org/licenses/gpl.html) as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

The following JavaScript libraries are bundled in this software:

- [foliate-js](https://github.com/johnfactotum/foliate-js), which is MIT licensed.
- [zip.js](https://github.com/gildas-lormeau/zip.js), which is licensed under the BSD-3-Clause license.
- [fflate](https://github.com/101arrowz/fflate), which is MIT licensed.
- [PDF.js](https://github.com/mozilla/pdf.js), which is licensed under Apache License 2.0.
