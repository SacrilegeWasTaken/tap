class Ctf < Formula
  desc "Run clang-tidy per module defined in ctf.toml"
  homepage "https://codeberg.org/sacrilegewastaken/ctf"
  head "https://codeberg.org/sacrilegewastaken/ctf.git", branch: "main"

  depends_on "zig" => :build

  def install
    # Check Zig version meets the minimum requirement from build.zig.zon.
    zig_version = Utils.safe_popen_read("zig", "version").strip
    min_version = "0.15.2"
    if Version.new(zig_version) < Version.new(min_version)
      raise "zig #{zig_version} is too old; ctf requires >= #{min_version}"
    end

    # Apple removed arm64 from Xcode 26+ SDK TBD stubs.
    # Use Command Line Tools SDK which still ships arm64 support.
    clt_sdks = Dir.glob("/Library/Developer/CommandLineTools/SDKs/MacOSX*.sdk").sort
    if clt_sdks.empty?
      raise <<~EOS
        Command Line Tools SDK not found at /Library/Developer/CommandLineTools/SDKs/.
        Install it with: xcode-select --install
      EOS
    end
    ENV["DEVELOPER_DIR"] = "/Library/Developer/CommandLineTools"
    ENV["SDKROOT"] = clt_sdks.last

    system "zig", "build", "-Doptimize=ReleaseSafe",
           "--global-cache-dir", "#{buildpath}/.zig-cache",
           "--prefix", prefix
    # Remove Gatekeeper quarantine from the unsigned binary (no-op if absent)
    quiet_system "xattr", "-d", "com.apple.quarantine", bin/"ctf"
  end

  test do
    system bin/"ctf", "--help"
  end
end
