# HMUtilities Swift SDK

The HMUtilities hosts a set of extensions, and other functionality, commonly used in other High Mobility's *Swift* libraries.

Table of contents
=================
<!--ts-->
   * [Features](#features)
   * [Integration](#integration)
   * [Requirements](#requirements)
   * [Contributing](#contributing)
   * [License](#license)
<!--te-->


## Features

**Binary Serialization**: Converting *types* conforming to `HMBytesConvertable` to *bytes* and back. Out of the box support for basic Swift types like `String`, `Int`, `Double`, `URL` and more.

**Hex**: Converting between hex strings and bytes.


## Integration

It's **recommended** to use the library through *Swift Package Manager* (SPM), which is now also built-in to Xcode and accessible in `File > Swift Packages > ...` or  going to project settings and selecting `Swift Packages` in the top-center.  
When targeting a Swift package, the `Package.swift` file must include `.package(url: "https://github.com/highmobility/hmutilities-swift", .upToNextMinor(from: "[__version__]")),` under *dependencies*.
  

If SPM is not possible, the source can be downloaded directly from Github
and built into an `.xcframework` using an accompaning script: [XCFrameworkBuilder.sh](https://github.com/highmobility/hmutilities-swift/tree/master/Scripts/XCFrameworkBuilder.sh). The created package includes both the simulator and device binaries, which must then be dropped (linked) to the target Xcode project.

Furthermore, when `.xcframework` is also not suitable, the library can be made into a *fat binary* (`.framework`) by running [UniversalBuildScript.sh](https://github.com/highmobility/hmutilities-swift/tree/master/Scripts/UniversalBuildScript.sh). This combines both simulator and device slices into one binary, but requires the simulator slice to be removed *before* being able to upload to *App Store Connect* – for this there is a [AppStoreCompatible.sh](https://github.com/highmobility/hmutilities-swift/tree/master/Scripts/AppStoreCompatible.sh) script included inside the created `.framework` folder.


## Requirements

HMUtilities Swift SDK requires Xcode 11.0 or later and is compatible with apps targeting iOS 10.0 or above.


## Contributing

We would love to accept your patches and contributions to this project. Before getting to work, please first discuss the changes that you wish to make with us via [GitHub Issues](https://github.com/highmobility/hmutilities-swift/issues), [Spectrum](https://spectrum.chat/high-mobility/) or [Slack](https://slack.high-mobility.com/).

See more in [CONTRIBUTING.md](https://github.com/highmobility/hmutilities-swift/tree/master/CONTRIBUTING.md)


## License

This repository is using MIT license. See more in [LICENSE](https://github.com/highmobility/hmutilities-swift/tree/master/LICENSE)
