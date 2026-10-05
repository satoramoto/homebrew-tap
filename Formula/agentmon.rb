class Agentmon < Formula
  desc "Terminal monitor for what AI coding agents cost your Mac"
  homepage "https://github.com/satoramoto/agentmon"
  url "https://rubygems.org/downloads/agentmon-0.1.0.gem"
  sha256 "0cf80379a22717ceda1a037cbd639c1d7c133ffc831d01df4fc0e196d7c539f9"
  license "MIT"

  depends_on :macos
  depends_on "ruby"

  # Runtime gems, installed into libexec next to agentmon. fiddle has a C extension; it's a
  # bundled gem in Homebrew's ruby, but GEM_PATH below hides those, so it's installed here too.
  resource "fiddle" do
    url "https://rubygems.org/downloads/fiddle-1.1.8.gem"
    sha256 "7fa8ee3627271497f3add5503acdbc3f40b32f610fc1cf49634f083ef3f32eee"
  end

  resource "r2ui" do
    url "https://rubygems.org/downloads/r2ui-0.2.0.gem"
    sha256 "3caa1f1b73561d3d308764bab0b0b7afc19e8c2a15ee1d047db48a47d0ffb58d"
  end

  def install
    ENV["GEM_HOME"] = libexec
    # brew fetches and verifies every resource before the build; don't download from in here.
    gems = resources.map(&:cached_download) + [cached_download]
    gems.each do |gem|
      system "gem", "install", gem, "--ignore-dependencies", "--no-document", "--install-dir", libexec
    end
    # The gem's binstub already runs opt/ruby/bin/ruby (stable across ruby upgrades).
    (bin/"agentmon").write_env_script libexec/"bin/agentmon", GEM_HOME: libexec, GEM_PATH: libexec
  end

  test do
    assert_match "agentmon #{version}", shell_output("#{bin}/agentmon --version")
    # Piped, agentmon prints one plain frame of this Mac and exits.
    frame = pipe_output(bin/"agentmon", "")
    assert_match "CPU", frame
    assert_match "Memory", frame
  end
end
