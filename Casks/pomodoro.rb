cask "pomodoro" do
  version "0.1.0"
  sha256 "b3fe61e0e6791bd555acccf93b17471d2cc9b333c3fb7b4caf9ff9223299204d"

  url "https://github.com/maokner/Pomodoro/releases/download/v#{version}/Pomodoro.dmg"
  name "Pomodoro"
  desc "Menu bar pomodoro timer with a retro timer device and a pixel cat"
  homepage "https://github.com/maokner/Pomodoro"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Pomodoro.app"

  # Pomodoro is ad-hoc signed but not notarized (no paid Apple Developer account),
  # so a quarantined first launch would hit the Gatekeeper wall. Clear quarantine
  # on install so it opens straight into the menu bar.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Pomodoro.app"], must_succeed: false
  end

  uninstall quit: "com.maokner.Pomodoro"

  zap trash: "~/Library/Preferences/com.maokner.Pomodoro.plist"
end
