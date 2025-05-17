#!/usr/bin/env bash
set -e

log(){
    echo -e "\033[0;34m\033[1m[IOZEVKA]: $@\033[0m" >&2
}

ensure(){
    if ! command -v $1 >/dev/null 2>&1; then
        log "$1 is required but is not installed. please install it and try again"
        exit 1
    fi
}
ensure zip
ensure unzip
ensure node
ensure npm
ensure python3
ensure fontforge
ensure ttfautohint

if [[ ! -d ./Iosevka ]]; then
  log "cloning the upstream Iosevka repository..."
  git clone --depth 1 https://github.com/be5invis/Iosevka.git --filter "blob:none"
fi

if [[ ! -d ./FontPatcher ]]; then
    log "downloading the Nerd Fonts FontPatcher..."
    wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FontPatcher.zip
    (mkdir FontPatcher && cd FontPatcher && unzip ../FontPatcher.zip)
fi

log "installing npm dependencies for Iosevka..."
(cd Iosevka && npm install)

log "copy the iozevka build plans into Iosevka directory..."
cp ./private-build-plans.toml ./Iosevka/

# build all six variations of iozevka
VARIATIONS=(IoZevkaCode IoZevkaQuasi IoZevkaSlabs IoZevkaTerm IoZevkaMono)
for variation in ${VARIATIONS[@]}; do
    log "building the $variation variation of iozevka..."
    (cd Iosevka && npm run build "contents::${variation}")
    log "built $variation successfully..."

    log "copying the $variation variation to out directory"
    mkdir -p ./out/$variation/ttf
    mkdir -p ./out/$variation/woff2
    cp ./Iosevka/dist/${variation}/TTF/* ./out/$variation/ttf
    cp ./Iosevka/dist/${variation}/WOFF2/* ./out/$variation/woff2
    cp ./Iosevka/dist/${variation}/${variation}.css ./out/$variation
    rm -rf out/$variation.zip
    (cd out && zip -r $variation.zip $variation)
    rm -rf out/$variation
done

log "building the IoZevkaNerd variation..."
(cd Iosevka && npm run build "ttf::IoZevkaNerd")
log "built IoZevkaNerd successfully..."

log "copying the IoZevkaNerd variation to out directory"
mkdir -p ./out/IoZevkaNerd.tmp
mkdir -p ./out/IoZevkaNerd/ttf
cp ./Iosevka/dist/IoZevkaNerd/TTF/* ./out/IoZevkaNerd.tmp/

# patch nerd fonts for ioZevkaTerm
log "patching the IoZevkaNerd variation fonts with the nerd font FontPatcher..."
for font in ./out/IoZevkaNerd.tmp/*.ttf; do
    python3 ./FontPatcher/font-patcher $font --outputdir ./out/IoZevkaNerd/ttf --makegroups=-1 --complete
done
log "successfully patched the IoZevkaNerd variation with the nerd font glyphs"
rm -rf ./out/IoZevkaNerd.tmp

rm -rf out/IoZevkaNerd.zip
(cd out && zip -r IoZevkaNerd.zip IoZevkaNerd)
rm -rf out/IoZevkaNerd

log "done. IoZevka is ready."
