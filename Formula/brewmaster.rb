class Brewmaster < Formula
  desc "Selective Homebrew package upgrades by semver bump level"
  homepage "https://github.com/pimlabs/brewmaster"
  url "https://github.com/pimlabs/brewmaster/archive/refs/tags/v0.12.2.tar.gz"
  sha256 "c5c87ed10a13488c697ee06567be8f46bdb910614fd85fffabc78c42b97ea783"
  version "0.12.2"
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
    assert_match "brewmaster 0.12.2", shell_output("#{bin}/brewmaster --version")
  end
end
