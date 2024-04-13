#!/usr/bin/env bash
set -e

# clone iosevka repository
[[ ! -d ./Iosevka ]] && git clone --depth 1 https://github.com/be5invis/Iosevka.git

# install iosevka npm dependencies
(cd Iosevka && npm install)

# add my customizations to iosevka repository
cp ./private-build-plans.toml ./Iosevka/

# build all six variations of iozevka
VARIATIONS=(IoZevkaCode IoZevkaQuasi IoZevkaSlabs IoZevkaTerm IoZevkaFixed IoZevkaMono)
for variation in ${VARIATIONS[@]}; do
    (cd Iosevka && npm run build "contents::${variation}")
done
(cd Iosevka && npm run build "ttf::IoZevkaNerd")

# extract fonts from the dist folder into the out folder
mkdir -p ./out/ttf
mkdir -p ./out/woff2
for font in ${VARIATION[@]}; do
    mkdir -p ./out/ttf/${font}
    mkdir -p ./out/woff2/${font}
    cp ./Iosevka/dist/${font}/TTF/* ./out/ttf/${font}/
    cp ./Iosevka/dist/${font}/WOFF2/* ./out/woff2/${font}/
done

mkdir -p ./out/ttf/IosevkaNerd
cp ./Iosevka/dist/IosevkaNerd/TTF/* ./out/ttf/IosevkaNerd/

# download nerd font's font pacher
if [[ ! -d ./FontPatcher ]]; then
    wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FontPatcher.zip
    (mkdir FontPatcher && cd FontPatcher && unzip ../FontPatcher.zip)
fi

# patch nerd fonts for ioZevkaTerm
mkdir out/ttf/IoZevkaNerd -p
for font in ./out/ttf/IoZevkaNerd/*.ttf; do
    ./FontPatcher/font-patcher $font --outputdir ./out/ttf/IoZevkaNerd --makegroups=-1
done

# archive fonts in a zip file
rm -rf out/ttf.zip && zip -r out/ttf.zip out/ttf/*
rm -rf out/ttf.zip && zip -r out/woff2.zip out/woff2/*

echo "done."
