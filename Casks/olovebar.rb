cask "olovebar" do
    version :latest
    sha256 "92328ddb7fdd0506e51151a8fb24b0c7e5949aa7ad19c54347ceede3c5a6a3a7"

    url "https://codeberg.org/sacrilegewastaken/olovebar/releases/download/latest/OLoveBar.dmg"
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