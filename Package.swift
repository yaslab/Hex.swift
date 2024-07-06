// swift-tools-version: 5.4

import PackageDescription

let package = Package(
    name: "Hex.swift",
    platforms: [
        .iOS(.v12), .tvOS(.v12), .watchOS(.v4), .macOS(.v10_13)
    ],
    products: [
        .library(name: "Hex", targets: ["Hex"])
    ],
    targets: [
        .target(name: "Hex"),
        .testTarget(name: "HexTests", dependencies: ["Hex"]),
    ]
)
