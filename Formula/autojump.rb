class Autojump < Formula
  desc "Shell extension to jump to frequently used directories"
  homepage "https://github.com/wting/autojump"
  url "https://github.com/wting/autojump/archive/release-v22.5.1.tar.gz"
  sha256 "765fabda130eb4df70d1c1e5bc172e1d18f8ec22c6b89ff98f1674335292e99f"
  head "https://github.com/wting/autojump.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "29d37b9fc31a978d0767c4925e88fa9fe3cebf4a9f9278fa82a96baf5caa0db4" => :sierra
    sha256 "29d37b9fc31a978d0767c4925e88fa9fe3cebf4a9f9278fa82a96baf5caa0db4" => :el_capitan
    sha256 "29d37b9fc31a978d0767c4925e88fa9fe3cebf4a9f9278fa82a96baf5caa0db4" => :yosemite
    sha256 "69d2a91aab0d0885a9e1c4521cc36bfa4c59c58c371c45a4833544c9b826bc1f" => :x86_64_linux # glibc 2.19
  end

  def install
    system "./install.py", "-d", prefix, "-z", zsh_completion

    # Backwards compatibility for users that have the old path in .bash_profile
    # or .zshrc
    (prefix/"etc").install_symlink prefix/"etc/profile.d/autojump.sh"

    libexec.install bin
    bin.write_exec_script libexec/"bin/autojump"
  end

  def caveats; <<-EOS.undent
    Add the following line to your ~/.bash_profile or ~/.zshrc file (and remember
    to source the file to update your current session):
      [ -f #{etc}/profile.d/autojump.sh ] && . #{etc}/profile.d/autojump.sh

    If you use the Fish shell then add the following line to your ~/.config/fish/config.fish:
      [ -f #{HOMEBREW_PREFIX}/share/autojump/autojump.fish ]; and source #{HOMEBREW_PREFIX}/share/autojump/autojump.fish
    EOS
  end

  test do
    path = testpath/"foo/bar"
    path.mkpath
    output = shell_output("bash -c '. #{etc}/profile.d/autojump.sh; j -a #{path.relative_path_from(testpath)}; j foo >/dev/null; pwd'").strip
    assert_equal path.realpath.to_s, output
  end
end
