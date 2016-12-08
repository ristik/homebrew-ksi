class Libksi < Formula
  desc "KSI C SDK"
  homepage "https://guardtime.github.io/libksi/"
  url "https://github.com/guardtime/libksi/archive/v3.11.1893.tar.gz"
  version "3.11.1893"
  sha256 "2f8351b9dc3ed9168d372b5bb5305e4a6c813455067ecb5be3589c263234dad4"

  depends_on "openssl"
  depends_on "curl"
  # Release tarball misses configure/make scripts
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  head do
    url "https://github.com/guardtime/libksi.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
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
    (testpath/"test.c").write <<-EOS.undent
      #include <ksi/ksi.h>
      #include <assert.h>
      int main()
      {
        KSI_CTX *ksi = NULL;
        assert(KSI_CTX_new(&ksi) == KSI_OK);
        KSI_CTX_free(ksi);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}",
                   "-lksi", "-o", "test"
    system "./test" 
  end
end

