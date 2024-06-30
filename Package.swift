// swift-tools-version: 5.4

import PackageDescription

let package = Package(
    name: "Hex.swift",
    products: [
        .library(name: "Hex", targets: ["Hex"]),
    ],
    targets: [
        .target(name: "Hex"),
        .testTarget(name: "HexTests", dependencies: ["Hex"]),
    ]
)
