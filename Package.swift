// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HeliumSwift",
    platforms: [
        .macOS(.v15),
    ],
    products: [
        .library(
            name: "HeliumSwift",
            targets: ["HeliumSwift"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/GetAutomaApp/SwiftWebDriver.git", branch: "master"),
        .package(url: "https://github.com/apple/swift-log", from: "1.6.0"),
        .package(url: "https://github.com/GetAutomaApp/AutomaUtilities", branch: "main"),
    ],
    targets: [
        .target(
            name: "HeliumSwift",
            dependencies: [
                .product(name: "SwiftWebDriver", package: "SwiftWebDriver"),
                .product(name: "Logging", package: "swift-log"),
                .product(name: "AutomaUtilities", package: "AutomaUtilities"),
            ]
        ),
        .testTarget(
            name: "HeliumSwiftTests",
            dependencies: ["HeliumSwift"]
        ),
    ]
)
