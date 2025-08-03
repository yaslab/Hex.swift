// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Hex.swift",
    platforms: [
        .iOS(.v14), .tvOS(.v14), .watchOS(.v7), .macOS(.v11), .macCatalyst(.v14),
    ],
    products: [
        .library(name: "Hex", targets: ["Hex"])
    ],
    targets: [
        .target(name: "Hex"),
        .testTarget(name: "HexTests", dependencies: ["Hex"]),
    ]
)
