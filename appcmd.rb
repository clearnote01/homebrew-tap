class Appcmd < Formula
  desc "Right-Command based app switcher for macOS"
  homepage "https://github.com/clearnote01/appcmd"
  url "https://github.com/clearnote01/appcmd/archive/refs/tags/v1.0.6.tar.gz"
  sha256 "05118c3d9b29fb1d39a09b7715d95a1ba68f25cc2209db73327e853153a0fd04"
  license "MIT"

  def install
    # Dynamically inject the Homebrew version into the Info.plist before building
    system "/usr/libexec/PlistBuddy", "-c", "Set :CFBundleShortVersionString #{version}", "Sources/Info.plist"
    
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/appcmd"
  end

  service do
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
