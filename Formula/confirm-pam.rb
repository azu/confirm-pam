class ConfirmPam < Formula
  desc "A CLI tool for biometric authentication confirmation"
  homepage "https://github.com/azu/confirm-pam"
  url "https://github.com/azu/confirm-pam/releases/download/v0.3.2/confirm-pam-macos-amd64.tar.gz"
  sha256 "6d8fcd74313da538a5c0569769f6b527223e3424af217a2a4239a2cd8b15a35a"
  license "MIT"

  def install
    bin.install "confirm-pam"
  end

  test do
    assert_match "confirm-pam", shell_output("#{bin}/confirm-pam --help")
  end
end