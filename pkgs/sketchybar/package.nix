{
  stdenvNoCC,
  fetchFromGitHub,
  apple-sdk_15,
  llvmPackages_21,
  gnumake,
}:
# Build with unwrapped clang + system ld to work around cctools-1010.6 ld crash on macOS 26.
# Requires system CommandLineTools SDK at /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk.
stdenvNoCC.mkDerivation {
  pname = "sketchybar";
  version = "2.24.0";

  src = fetchFromGitHub {
    owner = "FelixKratz";
    repo = "SketchyBar";
    rev = "v2.24.0";
    hash = "sha256-5tyc/yYzdV/3JTtujuj7le/14XkC7TlN/nZg7tOZsNg=";
  };

  nativeBuildInputs = [
    llvmPackages_21.clang-unwrapped
    apple-sdk_15
    gnumake
  ];

  buildPhase = let
    nixSdk = "${apple-sdk_15}/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk";
    systemSdk = "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk";
    clang = "${llvmPackages_21.clang-unwrapped}/bin/clang";
    rt = "/Library/Developer/CommandLineTools/usr/lib/clang/21/lib/darwin/libclang_rt.osx.a";
  in ''
    make arm64 \
      CC="${clang}" \
      CFLAGS="-std=c99 -Wall -O3 -ffast-math -fvisibility=hidden -fno-common \
              -target arm64-apple-macos11 \
              -mmacosx-version-min=11.0 \
              -isystem ${nixSdk}/usr/include \
              -F${nixSdk}/System/Library/Frameworks \
              -fuse-ld=/usr/bin/ld \
              --sysroot ${systemSdk}" \
      LIBS="${rt} \
            -framework Carbon -framework AppKit -framework QuartzCore \
            -framework CoreAudio -framework CoreWLAN -framework CoreVideo -framework IOKit \
            -F/System/Library/PrivateFrameworks -framework SkyLight \
            -framework DisplayServices -framework MediaRemote"
  '';

  installPhase = ''
    runHook preInstall
    install -Dm755 bin/sketchybar $out/bin/sketchybar
    runHook postInstall
  '';

  meta.mainProgram = "sketchybar";
}
