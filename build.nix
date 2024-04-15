{
    stdenv,
    fetchFromGitHub,
    pkg-config,
    json-glib,
    rofi-unwrapped,
    autoreconfHook,
    cairo,
    ...
}:
stdenv.mkDerivation ( finalAttrs: rec {
    name = "iozevka";
    src = fetchFromGitHub {
        owner = "OmarCastro";
  repo = "${name}";
  rev = "0a2ba561aa9a31586c0bc8203f8836a18a1f664e";
  hash = "sha256-U955hzd55xiV5XdQ18iUIwNLn2JrvuHsItgUSf6ww58=";
    };
    nativeBuildInputs = [
  pkg-config
  json-glib
    ];
    buildInputs = [
        autoreconfHook
        rofi-unwrapped
  cairo
    ];
    patches = [
        ./patch
    ];
})
