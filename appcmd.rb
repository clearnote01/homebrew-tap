class Appcmd < Formula
  desc "Right-Command based app switcher for macOS"
  homepage "https://github.com/clearnote01/appcmd"
  url "https://github.com/clearnote01/appcmd/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "586d56676b9bfe092d44a4bc02680f6787255e8a875f1612706e1a8f1baaeddd"
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
