cask "olovebar@1.3.1" do
  version "1.3.1"
  sha256 "c595becdd0cc30d2b7ca5bd899d5aa5f74503fa9ab4bed84f41b06b0e85ed5af"

  url "https://codeberg.org/sacrilegewastaken/olovebar/releases/download/1.3.1/OLoveBar.dmg"
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
