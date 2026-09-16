{
  lib,
  fetchurl,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ical-guy";
  version = "0.13.0";

  src = fetchurl {
    url = "https://github.com/itspriddle/ical-guy/releases/download/v${finalAttrs.version}/ical-guy-v${finalAttrs.version}-macos-universal.tar.gz";
    hash = "sha256-QmUk3Wr/zI2GdD2MLkBXmAlF7+jmwp5hZy0j+GnUpA4=";
  };

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    install -Dm755 ical-guy $out/bin/ical-guy
    install -Dm644 man/man1/ical-guy.1 $out/share/man/man1/ical-guy.1

    runHook postInstall
  '';

  meta = {
    description = "Modern Swift CLI for querying macOS calendar events and reminders";
    homepage = "https://github.com/itspriddle/ical-guy";
    license = lib.licenses.mit;
    platforms = lib.platforms.darwin;
    mainProgram = "ical-guy";
  };
})
