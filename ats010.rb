require "formula"

class Ats010 < Formula
  homepage "http://www.ats-lang.org/"
  url "https://downloads.sourceforge.net/project/ats2-lang/ats2-lang/ats2-postiats-0.1.0/ATS2-Postiats-0.1.0.tgz"
  sha1 ""

  bottle do
    root_url "https://raw.githubusercontent.com/hsk/homebrew-tap/master/bottles"

    cellar :any
    sha1 "" => :mavericks
  end

  depends_on "gmp"

  def install
    ENV.deparallelize

    ENV["PATSHOME"] = "#{HOMEBREW_PREFIX}/lib/ats2-postiats-0.1.0/"

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
      export PATSHOME=#{HOMEBREW_PREFIX}/lib/ats2-postiats-0.1.0/

    EOS
  end

end
