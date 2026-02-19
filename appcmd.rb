class Appcmd < Formula
  desc "Right-Command based app switcher for macOS"
  homepage "https://github.com/clearnote01/appcmd"
  url "https://github.com/clearnote01/appcmd/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "74e0c58558164eb913a084d33a12d9c208e26a5008d976eb5e02a1b005b3ccd9"
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
