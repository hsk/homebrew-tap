require "formula"

class Caper < Formula
  url "https://github.com/jonigata/caper.git", :branch => 'master'
  homepage "http://jonigata.github.io/caper/caper.html"
  head "https://github.com/jonigata/caper.git", :using => :git
  sha1 ""
  version 'latest'

  def install
    system "make all"
    bin.install Dir["caper/caper", "capella/capella"]
  end

end
