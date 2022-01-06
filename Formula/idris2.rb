class Idris2 < Formula
  desc "Pure functional programming language with dependent types"
  homepage "https://www.idris-lang.org/"
  url "https://github.com/idris-lang/Idris2/archive/v0.3.0.tar.gz"
  sha256 "2b1a921c3b46eec629936579a93319b2adb1c66a61302cd5f0b53017a07b1b74"
  license "BSD-3-Clause"
  head "https://github.com/idris-lang/Idris2.git"

  bottle do
    cellar :any
    sha256 "14c0047e074da112ced6ac7bb2e8aeed67661fe53ca1ff673bbb93f8adcc3e18" => :big_sur
    sha256 "970049099696d913196792a16019a86980ff770ffd476d28bc45eae8f27f0c2d" => :catalina
    sha256 "d54f0fca83f55d63bf65e81a3cf7e6f268133294c02a1498c07183ac36b36fe6" => :mojave
  end

  depends_on "coreutils" => :build
  depends_on "chezscheme"

  def install
    ENV.deparallelize
    scheme = Formula["chezscheme"].bin/"chez"
    system "make", "bootstrap", "SCHEME=#{scheme}", "PREFIX=#{libexec}"
    system "make", "install", "PREFIX=#{libexec}"
    # idris2.so is an executable file generated by Idris2
    bin.install "#{libexec}/bin/idris2_app/idris2.so" => "idris2"
    lib.install_symlink Dir["#{libexec}/lib/*.dylib"]
  end

  test do
    (testpath/"hello.idr").write <<~EOS
      module Main
      main : IO ()
      main = putStrLn "Hello, Homebrew!"
    EOS

    system bin/"idris2", "hello.idr", "-o", "hello"
    assert_equal "Hello, Homebrew!",
                 shell_output("./build/exec/hello_app/hello.so").chomp
  end
end