class ConfirmPam < Formula
  desc "A CLI tool for biometric authentication confirmation"
  homepage "https://github.com/azu/confirm-pam"
  url "https://github.com/azu/confirm-pam/releases/download/v0.2.0/confirm-pam-macos-amd64.tar.gz"
  sha256 "ab426d487246d10f4d3253b7adbcf579574a2edd39308d5b94ec19fc47da70de"
  license "MIT"

  def install
    bin.install "confirm-pam"
  end

  test do
    assert_match "confirm-pam", shell_output("#{bin}/confirm-pam --help")
  end
end