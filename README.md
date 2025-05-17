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

Here’s your Markdown table formatted properly:
| Font Name     | Features                                       | Use Case                                 | Nix Package        | Download Link |
|---------------|------------------------------------------------|------------------------------------------|--------------------|---------------|
| ioZevkaCode   | Monospace + ligatures                          | Code editors                             | `iozevka-code`     | ...           |
| ioZevkaQuasi  | Sans-serif variable-width                      | UI and display font                      | `iozevka-quasi`    | ...           |
| ioZevkaSlabs  | Serif variable-width                           | Articles and documentation               | `iozevka-slabs`    | ...           |
| ioZevkaTerm   | Monospace + fixed spacing + terminal ligatures | Terminal emulators                       | `iozevka-term`     | ...           |
| ioZevkaNerd   | ioZevkaTerm + nerd icons                       | Terminal emulators                       | `iozevka-nerd`     | ...           |
| ioZevkaMono   | Monospace + fixed spacing                      | Generic monospace font with no ligatures | `iozevka-mono`     | ...           |


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