class Agentmon < Formula
  desc "Terminal monitor for what AI coding agents cost your Mac"
  homepage "https://github.com/satoramoto/agentmon"
  # LOCAL TEST SOURCE: agentmon 0.1.0 isn't on RubyGems yet. Once it is, replace with
  #   url "https://rubygems.org/downloads/agentmon-0.1.0.gem"
  url "file:///private/tmp/claude-501/-Users-ryan-The-Source-agentmon/98b7bafe-2b49-4f0e-9555-10e8d52fc9e1/scratchpad/gems/agentmon-0.1.0.gem"
  sha256 "1581cacb88e52e3b6b745e5f2b53af6d9f5312fa0762a775a90b7fa7aa4a100c"
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
    # LOCAL TEST SOURCE: r2ui 0.2.0 isn't on RubyGems yet. Once it is, replace with
    #   url "https://rubygems.org/downloads/r2ui-0.2.0.gem"
    url "file:///private/tmp/claude-501/-Users-ryan-The-Source-agentmon/98b7bafe-2b49-4f0e-9555-10e8d52fc9e1/scratchpad/gems/r2ui-0.2.0.gem"
    sha256 "b6398c2dd88e5c9ee845347293cd5463a45ae1557426cfe3ee2aa665e9fcffc5"
  end

  def install
    ENV["GEM_HOME"] = libexec
    gems = resources.map(&:fetch) + [cached_download]
    gems.each do |gem|
      system "gem", "install", gem, "--ignore-dependencies", "--no-document", "--install-dir", libexec
    end
    (bin/"agentmon").write_env_script libexec/"bin/agentmon",
                                      GEM_HOME: libexec, GEM_PATH: libexec,
                                      PATH:     "#{Formula["ruby"].opt_bin}:$PATH"
  end

  test do
    assert_match "agentmon #{version}", shell_output("#{bin}/agentmon --version")
    # Piped, agentmon prints one plain frame of this Mac and exits.
    assert_match "agentmon", pipe_output("#{bin}/agentmon", "")
  end
end
