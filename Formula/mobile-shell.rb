class MobileShell < Formula
  desc "Remote terminal application"
  homepage "https://mosh.org"
  url "https://mosh.org/mosh-1.3.2.tar.gz"
  sha256 "da600573dfa827d88ce114e0fed30210689381bbdcff543c931e4d6a2e851216"
  revision 1

  bottle do
    sha256 "05e337d886666e085bc1a37656aff5e57db14e9aec05f10d65a675637d24b52f" => :sierra
    sha256 "e5c563d94f2fd0ca03545ad11feaf8f7318ec1ec8d03564bebc0a98c2e295fde" => :el_capitan
    sha256 "a59848c0b7e2a9b6cbfdc8579bc6d120e8a184d15d09cbbb6e3c37de8feb002d" => :yosemite
    sha256 "2a9e053ca44c1bcf60eafc98592d0f24ced479c74ee820bcacdadab994d42e87" => :x86_64_linux # glibc 2.19
  end

  head do
    url "https://github.com/mobile-shell/mosh.git", :shallow => false

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  option "with-test", "Run build-time tests"

  deprecated_option "without-check" => "without-test"

  depends_on "pkg-config" => :build
  depends_on "protobuf"
  depends_on "tmux" => :build if build.with?("test") || build.bottle?
  unless OS.mac?
    depends_on "ncurses"
    depends_on "openssl"
  end

  def install
    # teach mosh to locate mosh-client without referring
    # PATH to support launching outside shell e.g. via launcher
    inreplace "scripts/mosh.pl", "'mosh-client", "\'#{bin}/mosh-client"

    system "./autogen.sh" if build.head?
    system "./configure", "--prefix=#{prefix}", "--enable-completion"
    system "make", "check" if build.with?("test") || build.bottle?
    system "make", "install"
  end

  test do
    system bin/"mosh-client", "-c"
  end
end
