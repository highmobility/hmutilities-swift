// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HMUtilities",
    products: [
        .library(name: "HMUtilities", type: .dynamic, targets: ["HMUtilities"]),
    ],
    targets: [
        .target(name: "HMUtilities", dependencies: []),
        .testTarget(name: "HMUtilitiesTests", dependencies: ["HMUtilities"]),
    ]
)
