# WRF-CMake Homebrew

```sh
brew tap wrf-cmake/wrf
# Apple Clang is not supported in latest avalable WRF-CMake release (4.0.3),
# however this has now been fixed and the fixes are available from the wrf-cmake branch.
# We pass the `--HEAD` flag to buld WRF-CMake and WPS-CMake from the latest commit from the wrf-cmake branch.
brew install wrf --HEAD -v
```

Note: If you see an error message about an internal compiler error then you're likely running out of memory.
To reduce memory usage set the `HOMEBREW_MAKE_JOBS=1` environment variable.

After installation, you can find WRF-CMake in Homebrew's cellar:
```sh
ls -al $(brew --cellar)/wrf
```
