class Appcmd < Formula
  desc "Right-Command based app switcher for macOS"
  homepage "https://github.com/clearnote01/appcmd"
  url "https://github.com/clearnote01/appcmd/archive/refs/tags/v1.0.4.tar.gz"
  sha256 "f85c2eb0c49f78370930c4790feb31e80f750dc385ad63ff1e95883455ca5264"
  license "MIT"

  def install
    # Build with Info.plist embedded for stable identity
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/appcmd"
  end

  service do
    # Use the stable opt_bin path to help with Accessibility permissions
    run [opt_bin/"appcmd"]
    keep_alive true
    process_type :background
  end

  def caveats
    <<~EOS
      After installation/upgrade, you must grant Accessibility permissions:
      1. Open System Settings > Privacy & Security > Accessibility.
      2. If "appcmd" is already there, remove it with the (-) button and add it again.
      3. Add: #{opt_bin}/appcmd
    EOS
  end
end
