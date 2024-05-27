#!/usr/bin/env bash
set -e

# clone iosevka repository
[[ ! -d ./Iosevka ]] && git clone --depth 1 https://github.com/be5invis/Iosevka.git

# install iosevka npm dependencies
(cd Iosevka && npm install)

# add my customizations to iosevka repository
cp ./private-build-plans.toml ./Iosevka/

# build all six variations of iozevka
VARIATIONS=(IoZevkaCode IoZevkaQuasi IoZevkaSlabs IoZevkaTerm IoZevkaMono)
for variation in ${VARIATIONS[@]}; do
    (cd Iosevka && npm run build "contents::${variation}")
done
(cd Iosevka && npm run build "ttf::IoZevkaNerd")

# extract fonts from the dist folder into the out folder
mkdir -p ./out/ttf
mkdir -p ./out/woff2
for font in ${VARIATIONS[@]}; do
    mkdir -p ./out/ttf/${font}
    mkdir -p ./out/woff2/${font}
    cp ./Iosevka/dist/${font}/TTF/* ./out/ttf/${font}/
    cp ./Iosevka/dist/${font}/WOFF2/* ./out/woff2/${font}/
done

mkdir -p ./out/nerd.tmp
mkdir -p ./out/nerd
cp ./Iosevka/dist/IoZevkaNerd/TTF/* ./out/nerd.tmp/

# download nerd font's font pacher
if [[ ! -d ./FontPatcher ]]; then
    wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FontPatcher.zip
    (mkdir FontPatcher && cd FontPatcher && unzip ../FontPatcher.zip)
fi

# patch nerd fonts for ioZevkaTerm
for font in ./out/nerd.tmp/*.ttf; do
    python ./FontPatcher/font-patcher $font --outputdir ./out/nerd --makegroups=-1 --complete
done
rm -rf ./out/nerd.tmp

# archive fonts in a zip file
rm -rf out/ttf.zip && (cd out && zip -r ttf.zip ttf/)
rm -rf out/woff2.zip && (cd out && zip -r woff2.zip woff2/)
rm -rf out/nerd.zip && (cd out && zip -r nerd.zip nerd/)

echo "done."
