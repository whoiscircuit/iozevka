# Iozevka

this is my custom version of the iosevka font.

## Build/Install
you can install/build iozevka with nix without worrying about dependencies.
building the fonts will take a long time.

you can build the fonts with:
```
nix build .#iozevka-git
```

the flake also provides an overlay with multiple `iozevka-*` packages that you can use in your home-manager/nixos configs.

| Font Name     | Features                                       | Use Case                                 | Nix Package        | Download Link |
|---------------|------------------------------------------------|------------------------------------------|--------------------|---------------|
| ioZevkaCode   | Monospace + ligatures                          | Code editors                             | `iozevka-code`     | [Download](https://github.com/whoiscircuit/iozevka/releases/download/v1.2/IoZevkaCode.zip) |
| ioZevkaQuasi  | Sans-serif variable-width                      | UI and display font                      | `iozevka-quasi`    | [Download](https://github.com/whoiscircuit/iozevka/releases/download/v1.2/IoZevkaQuasi.zip) |
| ioZevkaSlabs  | Serif variable-width                           | Articles and documentation               | `iozevka-slabs`    | [Download](https://github.com/whoiscircuit/iozevka/releases/download/v1.2/IoZevkaSlabs.zip) |
| ioZevkaTerm   | Monospace + fixed spacing + terminal ligatures | Terminal emulators                       | `iozevka-term`     | [Download](https://github.com/whoiscircuit/iozevka/releases/download/v1.2/IoZevkaTerm.zip) |
| ioZevkaNerd   | ioZevkaTerm + nerd icons                       | Terminal emulators                       | `iozevka-nerd`     | [Download](https://github.com/whoiscircuit/iozevka/releases/download/v1.2/IoZevkaNerd.zip) |
| ioZevkaMono   | Monospace + fixed spacing                      | Generic monospace font with no ligatures | `iozevka-mono`     | [Download](https://github.com/whoiscircuit/iozevka/releases/download/v1.2/IoZevkaMono.zip) |


### Manual
For the iosevka builder you need:
```bash
git nodejs npm ttfautohint zip # nod version 18 or higher
```
and for the nerd font patcher you need:
```bash
wget unzip python3 fontforge python3-fontforge zip
```
after that you can run the build.sh script:
```bash
./build.sh
```
