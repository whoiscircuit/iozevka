# Iozevka

this is my custom version of the iosevka font.

## Requirements

### Nix
you can install/build iozevka with nix without worrying about dependencies

you can build the fonts with:
```
nix build .#iozevka-git
```

the flake also provides an overlay with `iozevka` and `iozevka-nerd` packages that you can use in your home-manager/nixos configs

### Manual
For the iosevka builder:
```
git nodejs npm ttfautohint
```
and for the nerd font patcher you need:
```
unzip python3 fontforge python3-fontforge
```
after that you can run the build.sh script:
```sh
./build.sh
```

# Font