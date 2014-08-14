require "formula"

class Caper < Formula
  url "https://github.com/jonigata/caper.git", :branch => 'master'
  homepage "http://jonigata.github.io/caper/caper.html"
  head "https://github.com/jonigata/caper.git", :using => :git
  sha1 ""
  version 'latest'

  bottle do
    cellar :any
    root_url "https://raw.githubusercontent.com/hsk/homebrew-tap/master/bottles"
    sha1 "6b9d72bd574832ab3c9eeca331c573dcb55ea8b9" => :mavericks
  end

  def install
    system "make all"
    bin.install Dir["caper/caper", "capella/capella"]
  end

end
