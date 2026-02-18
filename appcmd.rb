class Appcmd < Formula
  desc "Right-Command based app switcher for macOS"
  homepage "https://github.com/clearnote01/appcmd"
  url "https://github.com/clearnote01/appcmd/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "681782f0bd5f852112cb14dfc9b6305600b24bbe5b1204980c4f8dbf9d2e5192"
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
