# https://github.com/jason-m/whydoesnothing.work/tree/main/episode-6
{
  stdenv,
  lib,
  fetchurl,
  unzip
}:
stdenv.mkDerivation rec {
  pname = "icalBuddy";
  version = "1.10.1";

  src = fetchurl {
    url = "https://github.com/dkaluta/icalBuddy64/releases/download/v${version}/${pname}-v${version}.zip";
    sha256 = "sha256-cgpqM0TOMsLKt8PStoatjejZdEt0esSLJ1JH7VTLOUU=";
  };

  sourceRoot = "${pname}-v${version}";

  dontBuild = true;

  nativeBuildInputs = [unzip];

  installPhase = ''
    unzip ${src}

    mkdir -p $out/bin
    cp ${pname} $out/bin/
  '';

  meta = with lib; {
    description = "a command-line utility that can be used to get lists of events and tasks/to-do's from the OS X calendar database (the same one iCal uses)";
    homepage = "https://hasseg.org/icalBuddy";
    license = licenses.mit;
    platforms = platforms.darwin;
  };
}
