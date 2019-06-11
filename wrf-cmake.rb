# WRF-CMake (https://github.com/WRF-CMake/WRF).
# Copyright 2019 M. Riechert and D. Meyer. Licensed under the MIT License.

class WrfCmake < Formula
  desc "The Weather Research and Forecasting (WRF) model with CMake support"
  homepage "https://github.com/WRF-CMake/WRF"
  url "https://github.com/WRF-CMake/WRF.git",
      :branch => "wrf-cmake",
      :commit => "8b9edc944f0cbbfb22966850ae3724f617f0f705"
  version "4.1.wrf-cmake"
  sha256 "37814ee7bfe7077cba8bd0175258ef763380fce3e7d8aab2ea8360a902a11043"
  head "https://github.com/WRF-CMake/WRF.git", :branch => "wrf-cmake"

  depends_on "cmake" => :build
  depends_on "gcc" # for gfortran
  depends_on "jasper"
  depends_on "libpng"
  depends_on "netcdf"
  depends_on "open-mpi"

  resource "WPS" do
    url "https://github.com/WRF-CMake/WPS.git",
        :branch => "wps-cmake",
        :commit => "d918dc6da17b177aa1fe0082866274968f45a171"
  end

  # Note: If you get an internal compiler error when building WRF,
  # then you're likely running out of memory. To reduce memory usage,
  # set HOMEBREW_MAKE_JOBS=1.

  def install
    (buildpath/"WPS").install resource("WPS")

    # Prevent CMake from finding & using ifort
    ENV["FC"] = Formula["gcc"].opt_bin/"gfortran"

    wrf_args = *std_cmake_args.map + %W[
      -DCMAKE_INSTALL_PREFIX=#{prefix}/wrf
      -DNESTING=basic
      -DMODE=dmpar
    ]

    mkdir "build" do
      system "cmake", "..", *wrf_args
      system "make", "install"
    end

    # Ideally, WPS should be a separate formula, but it relies on the build tree of WRF,
    # which is not installed. Therefore, we build it here and install it in the WPS subfolder
    # of WRF.
    wps_args = std_cmake_args + %W[
      -DCMAKE_INSTALL_PREFIX=#{prefix}/wps
      -DWRF_DIR=#{buildpath}/build
    ]

    mkdir "WPS/build" do
      system "cmake", "..", *wps_args
      system "make", "install"
    end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test WRF`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
