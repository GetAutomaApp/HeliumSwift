// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HeliumSwift",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(
            name: "HeliumSwift",
            targets: ["HeliumSwift"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/GetAutomaApp/SwiftWebDriver.git", branch: "master"),
        .package(url: "https://github.com/apple/swift-log", from: "1.6.0")
    ],
    targets: [
        .target(
            name: "HeliumSwift",
            dependencies: [
                .product(name: "SwiftWebDriver", package: "SwiftWebDriver"),
                .product(name: "Logging", package: "swift-log")
            ]
        ),
        .testTarget(
            name: "HeliumSwiftTests",
            dependencies: ["HeliumSwift"]
        ),
    ]
)
