class KsiTool < Formula
  desc "KSI Command-line Tool"
  homepage "https://github.com/guardtime/ksi-tool/"
  url "https://github.com/guardtime/ksi-tool/archive/v2.7.1200.tar.gz"
  sha256 "544bb2569752ac09e41e827e7412f9d612ae57f895d06e29bd0f056ce08fc3ec"
  revision 1

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
    system "#{bin}/ksi", "--version"
  end
end
