require "formula"

class Strollmincaml < Formula
  url "https://github.com/hsk/strollmincaml.git", :branch => 'master'
  homepage "http://github.com/hsk/strollmincaml"
  head "https://github.com/hsk/strollmincaml.git", :using => :git
  sha1 ""
  version 'latest'

  depends_on 'ocaml'

  bottle do
    cellar :any
    root_url "https://raw.githubusercontent.com/hsk/homebrew-tap/master/bottles"
    sha1 "96c6dbf24b68977e02807b68e5c42575958e857c" => :mavericks
  end

  def install
    #ENV.deparallelize

    ENV["PATH"] = ENV["PATH"] + ':' + ENV["HOME"] +'/.opam/system/bin'
    system "cd l16polyinfer; "+ENV["HOME"]+"/.opam/system/bin/omake"
    system "mv l16polyinfer/lllc.opt ./lllc"
    bin.install Dir["lllc"]
  end

end
