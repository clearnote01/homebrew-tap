class Appcmd < Formula
  desc "Right-Command based app switcher for macOS"
  homepage "https://github.com/clearnote01/appcmd"
  url "https://github.com/clearnote01/appcmd/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "0ae54bbca18db33ce2b5aac339fdb508823b3d7da14e0b0953fab63d7342b172"
  license "MIT"


  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/appcmd"
  end

  service do
    run [opt_bin/"appcmd"]
    keep_alive true
    process_type :background
  end

  test do
    system "#{bin}/appcmd", "--help"
  end
end
