class Libcsp < Formula
  desc "Tiny header-only smart pointer library for C11/C23"
  homepage "https://codeberg.org/sacrilegewastaken/libcsp"
  head "https://codeberg.org/sacrilegewastaken/libcsp.git", branch: "main"

  def install
    include.install "include/csp.h"
    pkgshare.install "test"
  end

  test do
    cp_r (pkgshare/"test/."), testpath
    system ENV.cc, "test.c", "-std=c11", "-Wall", "-Wextra", "-pthread",
           "-I#{include}", "-o", "test"
    system "./test"
  end
end

