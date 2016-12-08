class KsiTool < Formula
  desc "KSI C SDK"
  homepage "https://github.com/guardtime/ksi-tool/"
  url "https://github.com/guardtime/ksi-tool/archive/v2.3.984.tar.gz"
  version "2.3.984"
  sha256 "4d259f9c8c8154f6176aeda5e395f174676defb575be0a6c0103a2c0c6b29a2b"

  depends_on "openssl"
  depends_on "curl"
  depends_on "libksi"
  # Release tarball misses configure/make scripts
  depends_on "autoconf" => :build
  depends_on "automake" => :build

  head do
    url "https://github.com/guardtime/ksi-tool.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end


  def install
    # system "autoreconf -if" if build.head?
    system "autoreconf -if"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"ksi"
  end
end
