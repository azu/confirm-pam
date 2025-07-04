class ConfirmPam < Formula
  desc "A CLI tool for biometric authentication confirmation"
  homepage "https://github.com/azu/confirm-pam"
  url "https://github.com/azu/confirm-pam/releases/download/v0.1.0/confirm-pam-macos-amd64.tar.gz"
  sha256 "636c9cb66c3c5244ad318e4cf9516f04713fd1ee946cac2cc8ed16bf4775c32f"
  license "MIT"

  def install
    bin.install "confirm-pam"
  end

  test do
    assert_match "confirm-pam", shell_output("#{bin}/confirm-pam --help")
  end
end