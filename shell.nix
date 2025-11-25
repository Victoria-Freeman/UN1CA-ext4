{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
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
    echo UN1CA Time!
  '';
}
