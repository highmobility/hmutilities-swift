// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HMUtilities",
    platforms: [
        .iOS(.v10),
        .macOS(.v10_10),
        .tvOS(.v10)
    ],
    products: [
        .library(name: "HMUtilities", targets: ["HMUtilities"]),
    ],
    targets: [
        .target(name: "HMUtilities", dependencies: []),
        .testTarget(name: "HMUtilitiesTests", dependencies: ["HMUtilities"]),
    ]
)
