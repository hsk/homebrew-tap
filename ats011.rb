require "formula"

class Ats011 < Formula
  homepage "http://www.ats-lang.org/"
  url "https://downloads.sourceforge.net/project/ats2-lang/ats2-lang/ats2-postiats-0.1.1/ATS2-Postiats-0.1.1.tgz"
  sha1 "555c820db67d14a30ac88ce1e70b4a6476adf8b5"

  bottle do
    root_url "https://github.com/hsk/homebrew-tap/raw/master"
    # root_url "https://raw.githubusercontent.com/hsk/homebrew-tap/master/"

    cellar :any
    sha1 "935c835f5be79be37025de28460c2d8f5788bedc" => :mavericks
  end

  depends_on "gmp"

  def install
    ENV.deparallelize

    ENV["PATSHOME"] = "#{HOMEBREW_PREFIX}/lib/ats2-postiats-0.1.1/"

    system "./configure", "--prefix=#{prefix}"

    # Disable GC support for patsopt
    # https://github.com/githwxi/ATS-Postiats/issues/76
    #system "make", "CCOMP=clang", "all"
    # system "make", "CCOMP=clang", "GCFLAG=-D_ATS_NGC", "all"
    system "make", "GCFLAG=-D_ATS_NGC", "all"
    #system "make", "all"
    system "make", "install"
  end

  test do
    (testpath/"hello.dats").write <<-EOS.undent
      #include "share/atspre_staload.hats"
      val _ = print ("Hello, world!\n")
      implement main0 () = ()
    EOS
    system "#{bin}/patscc hello.dats -o hello"
    IO.popen("./hello", "r") do |pipe|
      assert_match "Hello, world!", pipe.read
    end
  end

  def caveats; <<-EOS.undent
    Add the following line to your .bashrc or equivalent:
      export PATSHOME=#{HOMEBREW_PREFIX}/lib/ats2-postiats-0.1.1/

    EOS
  end

end
