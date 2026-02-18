class Appcmd < Formula
  desc "Right-Command based app switcher for macOS"
  homepage "https://github.com/clearnote01/appcmd"
  url "https://github.com/clearnote01/appcmd/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "77a7a141498767be808aaac77f6e698dfb7c243649cf45d17ea21c4ef70a0fb6"
  license "MIT"

  depends_on :xcode => ["14.0", :build]

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
