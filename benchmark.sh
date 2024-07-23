#!/usr/bin/env zsh

set -eu

SCRIPT_DIT=$(cd "$(dirname "$0")"; pwd)

if [ $# = 0 ]; then
  PACKAGE=".package(path: \"../\")"
else
  PACKAGE=".package(url: \"https://github.com/yaslab/Hex.swift.git\", exact: \"$1\")"
fi

cd "$SCRIPT_DIT"
mkdir -p ./benchmark/Sources/benchmark
cd benchmark

cat << EOF > ./Package.swift
// swift-tools-version: 5.6

import PackageDescription

let package = Package(
  name: "benchmark",
  platforms: [.macOS(.v11)],
  dependencies: [
    $PACKAGE
  ],
  targets: [
    .executableTarget(
      name: "benchmark", 
      dependencies: [.product(name: "Hex", package: "Hex.swift")])
  ]
)
EOF

cat << EOF > ./Sources/benchmark/main.swift
import Foundation
import Hex

let length = 5120
let loop = 25000

let hexData = Data((0 ..< length).map({ _ in 0x30 }))
let hexString = String(repeating: "0", count: length)

let bytes = Data(count: length)

print("method | time (s)")
print("--- | ---")

do {
  let start = Date()

  for _ in 0 ..< loop {
    _ = Data(hexEncoded: hexData)!
  }

  print("\`Data(hexEncoded: data)\` | " + String(format: "%.4f", Date().timeIntervalSince(start)))
}

do {
  let start = Date()

  for _ in 0 ..< loop {
    _ = Data(hexEncoded: hexString)!
  }

  print("\`Data(hexEncoded: string)\` | " + String(format: "%.4f", Date().timeIntervalSince(start)))
}

do {
  let start = Date()

  for _ in 0 ..< loop {
    _ = (bytes as any Collection<UInt8>).hexEncodedData()
  }

  print("\`Collection.hexEncodedData()\` | " + String(format: "%.4f", Date().timeIntervalSince(start)))
}

do {
  let start = Date()

  for _ in 0 ..< loop {
    _ = (bytes as any Collection<UInt8>).hexEncodedString()
  }

  print("\`Collection.hexEncodedString()\` | " + String(format: "%.4f", Date().timeIntervalSince(start)))
}

do {
  let start = Date()

  for _ in 0 ..< loop {
    _ = (bytes as any Sequence<UInt8>).hexEncodedData()
  }

  print("\`Sequence.hexEncodedData()\` | " + String(format: "%.4f", Date().timeIntervalSince(start)))
}

do {
  let start = Date()

  for _ in 0 ..< loop {
    _ = (bytes as any Sequence<UInt8>).hexEncodedString()
  }

  print("\`Sequence.hexEncodedString()\` | " + String(format: "%.4f", Date().timeIntervalSince(start)))
}
EOF

swift package clean
swift run -c release
