cask "olovebar@1.3.2" do
  version "1.3.2"
  sha256 "19ba34e97c0b6cfbb24f38da264b54192940a7b4545b0d216bb0c747a8b75925"

  url "https://codeberg.org/sacrilegewastaken/olovebar/releases/download/1.3.2/OLoveBar.dmg"
  name "OLoveBar"
  desc "Menu bar utility"
  homepage "https://codeberg.org/sacrilegewastaken/olovebar"

  postflight do
    if File.exist?("#{staged_path}/OLoveBar.app")
      system "xattr", "-r", "-d", "com.apple.quarantine", "#{staged_path}/OLoveBar.app"
    end

    if File.exist?("#{appdir}/OLoveBar.app")
      system "xattr", "-r", "-d", "com.apple.quarantine", "#{appdir}/OLoveBar.app"
    end
  end

  app "OLoveBar.app", target: "#{appdir}/OLoveBar.app"

  uninstall quit: "com.sacrilege.olovebar"

  zap trash: [
    "~/Library/Preferences/com.sacrilege.olovebar.plist",
    "~/Library/Application Support/OLoveBar",
  ]
end
