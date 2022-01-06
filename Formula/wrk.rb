class Wrk < Formula
  desc "HTTP benchmarking tool"
  homepage "https://github.com/wg/wrk"
  url "https://github.com/wg/wrk/archive/4.1.0.tar.gz"
  sha256 "6fa1020494de8c337913fd139d7aa1acb9a020de6f7eb9190753aa4b1e74271e"
  head "https://github.com/wg/wrk.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 2
    sha256 "39f3b454a93381e9350a3650745039deec765bff1f72eb7b6f3d449f1cabed3a" => :big_sur
    sha256 "65f16f71cfb120d12f0f993044db92b767c728274aa046917bee7ad4deacfd3e" => :mojave
    sha256 "ccc1cc4303847b70f940b765a9229476e7018328fbf202c02a00d9a13c63919e" => :high_sierra
    sha256 "82fd1323ac999e23107dcd1cdae9635ff047afd15532f42f8cb4e82dad0db257" => :sierra
  end

  depends_on "openssl@1.1"

  on_linux do
    depends_on "makedepend" => :build
    depends_on "pkg-config" => :build
  end

  conflicts_with "wrk-trello", because: "both install `wrk` binaries"

  def install
    ENV.deparallelize
    ENV["MACOSX_DEPLOYMENT_TARGET"] = MacOS.version
    system "make"
    bin.install "wrk"
  end

  test do
    system "#{bin}/wrk", "-c", "1", "-t", "1", "-d", "1", "https://example.com/"
  end
end
