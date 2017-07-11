class KsiTool < Formula
  desc "KSI Command-line Tool"
  homepage "https://github.com/guardtime/ksi-tool/"
  url "https://github.com/guardtime/ksi-tool/archive/v2.6.1136.tar.gz"
  sha256 "915c51380c9b1217c7633d88308f7d79564d837775e88754909548e509fe2d63"

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
