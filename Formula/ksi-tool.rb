class KsiTool < Formula
  desc "KSI C SDK"
  homepage "https://github.com/guardtime/ksi-tool/"
  url "https://github.com/guardtime/ksi-tool/archive/v2.4.1038.tar.gz"
  version "2.4.1038"
  sha256 "c551b0f0b2db7b79bb756dcef56eeae4a955d259daf679523108995c417f6198"

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
