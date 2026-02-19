class Appcmd < Formula
  desc "Right-Command based app switcher for macOS"
  homepage "https://github.com/clearnote01/appcmd"
  url "https://github.com/clearnote01/appcmd/archive/refs/tags/v1.1.4.tar.gz"
  sha256 "f645cec5793438527570cebe2eeb5044fc30d6173543e13ad6ce526d5248e2f1"
  license "MIT"

  def install
    # Dynamically inject the version into the source code before building
    inreplace "Sources/Version.swift", 'static let current = "dev"', "static let current = \"#{version}\""
    
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
      2. If \"appcmd\" is already there, remove it with the (-) button and add it again.
      3. Add: #{opt_bin}/appcmd
    EOS
  end
end
