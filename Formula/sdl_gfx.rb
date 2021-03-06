class SdlGfx < Formula
  desc "Graphics drawing primitives and other support functions"
  homepage "http://www.ferzkopp.net/joomla/content/view/19/14/"
  url "http://www.ferzkopp.net/Software/SDL_gfx-2.0/SDL_gfx-2.0.25.tar.gz"
  sha256 "556eedc06b6cf29eb495b6d27f2dcc51bf909ad82389ba2fa7bdc4dec89059c0"

  bottle do
    cellar :any
    sha256 "52829744591992f7c81ae5beb04f8be1a33229615425e4356ee3af863b9d2598" => :sierra
    sha256 "f14692eab7c7a7a60694ea6aca4094c6ceb869604f2c587dd044df880b3a747b" => :el_capitan
    sha256 "756fe923ceccdb3e9c5c7865298344a3520efe0bd549e493b109bc1506e6de29" => :yosemite
    sha256 "aa06ebfac9112febe86ec4a933d807ae88e87329498a71678bd52be51748d9dc" => :mavericks
    sha256 "3ae8415b5d00f2ccb74d4704e8d2d1f2b6eba07adc836373ff52ce056b5e98c1" => :x86_64_linux # glibc 2.19
  end

  depends_on "sdl"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-sdltest"
    system "make", "install"
  end
end
