# WRF-CMake Homebrew

```sh
brew tap wrf-cmake/wrf
brew install wrf --HEAD -v
```

Note: If you see an error message about an internal compiler error then you're likely running out of memory.
To reduce memory usage set the `HOMEBREW_MAKE_JOBS=1` environment variable.

After installation, you can find WRF-CMake in Homebrew's cellar:
```sh
ls -al $(brew --cellar)/wrf
```
