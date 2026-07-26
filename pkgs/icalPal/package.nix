# https://github.com/ajrosen/icalPal
{
  lib,
  ruby,
  buildRubyGem,
  fetchurl,
  rubyPackages,
}:
let
  plistGem = buildRubyGem {
    inherit ruby;
    gemName = "plist";
    version = "3.7.2";
    source = {
      remoteType = "gem";
      sha256 = "sha256-03pFJ8wRFgZDk99LQOHbvJTGX6nKLuxS7fmhNhZxikI=";
    };
  };
in
buildRubyGem {
  inherit ruby;
  gemName = "icalPal";
  version = "4.2.1";

  src = fetchurl {
    url = "https://github.com/ajrosen/icalPal/releases/download/icalPal-4.2.1/icalPal-4.2.1.gem";
    sha256 = "sha256-7IP8deF/mrw6POSSMvRm5Ymmekl92jimHJa8HfEP6ak=";
  };

  # Must be false to unpack the gem so we can patch ext/extconf.rb before rebuild.
  dontBuild = false;

  gemPath = [
    plistGem
    rubyPackages.sqlite3
  ];

  # extconf.rb tries to install deps at gem-install time (no native code).
  # It exits(0) without creating a Makefile, which breaks gem install.
  # Replace it with a proper no-op mkmf call; deps are in gemPath.
  postUnpack = ''
    cat > source/ext/extconf.rb <<'EOF'
require 'mkmf'
create_makefile('extconf')
EOF
  '';

  meta = with lib; {
    description = "Command-line tool to query the macOS Calendar and Reminders";
    homepage = "https://github.com/ajrosen/icalPal";
    license = licenses.gpl3Plus;
    platforms = platforms.darwin;
    mainProgram = "icalPal";
  };
}
