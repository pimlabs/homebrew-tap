class Brewmaster < Formula
  desc "Selective Homebrew package upgrades by semver bump level"
  homepage "https://github.com/pimlabs/brewmaster"
  url "https://github.com/pimlabs/brewmaster/archive/refs/tags/v0.13.1.tar.gz"
  sha256 "494eeb66f6e88dca898add570c3112c7fdad5d490112be43c0c610823039e1a2"
  version "0.13.1"
  license "MIT"

  depends_on "jq"

  def install
    bin.install "bin/brewmaster"
    libexec.install Dir["lib/brewmaster"]
    # Rewrite LIB_DIR to point to the installed location
    inreplace bin/"brewmaster",
      'LIB_DIR="${BREWMASTER_LIB:-$SCRIPT_DIR/../lib/brewmaster}"',
      "LIB_DIR=\"${BREWMASTER_LIB:-#{libexec}/brewmaster}\""

    bash_completion.install "completions/brewmaster.bash" => "brewmaster"
    zsh_completion.install "completions/brewmaster.zsh" => "_brewmaster"
    fish_completion.install "completions/brewmaster.fish"
    man1.install "docs/brewmaster.1"
  end

  test do
    assert_match "brewmaster 0.13.1", shell_output("#{bin}/brewmaster --version")
  end
end
