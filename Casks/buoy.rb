cask "buoy" do
  version "0.2.1"
  sha256 "046dc21da527b9884c27c550106b98a10ab1f469374dc5c0ac0bf73a82ab753c"

  url "https://github.com/maokner/Buoy/releases/download/v#{version}/Buoy.dmg"
  name "Buoy"
  desc "Menu bar utility that keeps any window on top via a live, interactive mirror"
  homepage "https://github.com/maokner/Buoy"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "Buoy.app"

  # Buoy is signed but not notarized (no paid Apple Developer account), so a
  # quarantined first launch would hit the Gatekeeper wall. Clear quarantine on
  # install so the app opens straight to its permission primer.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Buoy.app"],
                   sudo: false
  end

  zap trash: "~/Library/Preferences/com.maokner.Buoy.plist"

  caveats <<~EOS
    On first launch Buoy asks for Screen Recording, and for Accessibility
    when you pin in place. Grant them once; nothing leaves your Mac.
  EOS
end
