cask "buoy" do
  version "0.1.0"
  sha256 "d7daefae3d44abb02257d81319755d6cd3573323cbcb7dca787f3aaf9f191122"

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

  zap trash: "~/Library/Preferences/com.maokner.Buoy.plist"

  caveats <<~EOS
    Buoy is open source but not notarized (no paid Apple Developer account).
    If macOS blocks the first launch, allow it under
    System Settings -> Privacy & Security -> Open Anyway,
    or install without the quarantine flag:
      brew install --cask buoy --no-quarantine

    Buoy will ask for Screen Recording (the mirror is a window capture)
    and, for pin-in-place, Accessibility. Nothing leaves your Mac.
  EOS
end
