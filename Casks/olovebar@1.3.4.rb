cask "olovebar@1.3.4" do
  version "1.3.4"
  sha256 "73e42c76e47e414a96f2d4e50beb386b93ef68ab71322448ad0d68bcb597ba07"

  url "https://codeberg.org/sacrilegewastaken/olovebar/releases/download/1.3.4/OLoveBar.dmg"
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
