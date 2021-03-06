class LittleCms2 < Formula
  desc "Color management engine supporting ICC profiles"
  homepage "http://www.littlecms.com/"
  url "https://downloads.sourceforge.net/project/lcms/lcms/2.8/lcms2-2.8.tar.gz"
  sha256 "66d02b229d2ea9474e62c2b6cd6720fde946155cd1d0d2bffdab829790a0fb22"
  revision 1

  bottle do
    cellar :any
    sha256 "5175bace6103d7ca8fb014db619bc11cb0d0fb29bcd2430d8e3dac3bda745a69" => :sierra
    sha256 "23b02130356986222e3f6c16aa85cadd674e2fca33ebe044adc95a16c12bb093" => :el_capitan
    sha256 "3cbcf21c725ccb1a260433b99136762cbbe8938a33ecdc8cdc82a48c7eb5acb7" => :yosemite
    sha256 "7692b1d6a77051cd1f62bb41f43936350aca9864ea4889ac535d98fc03ebef2a" => :x86_64_linux # glibc 2.19
  end

  depends_on "jpeg" => :recommended
  depends_on "libtiff" => :recommended

  def install
    args = %W[--disable-dependency-tracking --prefix=#{prefix}]
    args << "--without-tiff" if build.without? "libtiff"
    args << "--without-jpeg" if build.without? "jpeg"

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/jpgicc", test_fixtures("test.jpg"), "out.jpg"
    assert File.exist?("out.jpg")
  end
end
