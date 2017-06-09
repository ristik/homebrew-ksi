class KsiTool < Formula
  desc "KSI Command-line Tool"
  homepage "https://github.com/guardtime/ksi-tool/"
  url "https://github.com/guardtime/ksi-tool/archive/v2.5.1125.tar.gz"
  sha256 "679fcd81783f5fdff2786c4a3b75fdd9071c5f9dba2d75da9eed3ece5bd60ccd"

  head do
    url "https://github.com/guardtime/ksi-tool.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  depends_on "openssl"
  depends_on "libksi"
  # Release tarball misses configure/make scripts
  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    # system "autoreconf", "-if" if build.head?
    system "autoreconf", "-if"
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
