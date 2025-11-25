{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs }: {
    devShells.x86_64-linux.default = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in pkgs.mkShell {
      nativeBuildInputs = with pkgs; [
        cmake pkg-config clang lld ccache bc unzip zip p7zip lz4 brotli attr jdk17_headless
      ];
      buildInputs = with pkgs; [
        ffmpeg gtest llvmPackages.libunwind pcre2 zstd zlib llvm
        protobuf libwebp openssl
        glibc.static
        zlib.static
      ];

      CC = "${pkgs.clang}/bin/clang";
      CXX = "${pkgs.clang}/bin/clang++";

      NIX_LDFLAGS = "-L${pkgs.glibc.static}/lib -L${pkgs.zlib.static}/lib";
      LDFLAGS = "-L${pkgs.glibc.static}/lib -L${pkgs.zlib.static}/lib";

      shellHook = ''
        export CC CXX LDFLAGS NIX_LDFLAGS PKG_CONFIG_PATH
        echo "✓ Static dev shell ready"
        echo "  CC=$CC"
        echo "  CXX=$CXX"
        echo "  LDFLAGS=$LDFLAGS"
      '';
    };
  };
}
