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
// swift-tools-version: 5.8

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

let _length = 5120
let _loop = 25600

let _hexData = Data((0 ..< _length).map({ _ in 0x30 }))
let _hexString = String(repeating: "0", count: _length)

let _bytes = Data(count: _length)

print("method | time (s)")
print("--- | ---")

@inline(never)
func decodeData(_ n: Int, hexData: Data) {
  let start = Date()

  for _ in 0 ..< n {
    _ = Data(hexEncoded: hexData)!
  }

  print("\`Data(hexEncoded: data)\` | " + String(format: "%.4f", Date().timeIntervalSince(start)))
}

@inline(never)
func decodeString(_ n: Int, hexString: String) {
  let start = Date()

  for _ in 0 ..< n {
    _ = Data(hexEncoded: hexString)!
  }

  print("\`Data(hexEncoded: string)\` | " + String(format: "%.4f", Date().timeIntervalSince(start)))
}

@inline(never)
func encodeCollectionIntoData<T: Collection<UInt8>>(_ n: Int, bytes: T) {
  let start = Date()

  for _ in 0 ..< n {
    _ = bytes.hexEncodedData()
  }

  print("\`Collection.hexEncodedData()\` | " + String(format: "%.4f", Date().timeIntervalSince(start)))
}

@inline(never)
func encodeCollectionIntoString<T: Collection<UInt8>>(_ n: Int, bytes: T) {
  let start = Date()

  for _ in 0 ..< n {
    _ = bytes.hexEncodedString()
  }

  print("\`Collection.hexEncodedString()\` | " + String(format: "%.4f", Date().timeIntervalSince(start)))
}

@inline(never)
func encodeSequenceIntoData<T: Sequence<UInt8>>(_ n: Int, bytes: T) {
  let start = Date()

  for _ in 0 ..< n {
    _ = bytes.hexEncodedData()
  }

  print("\`Sequence.hexEncodedData()\` | " + String(format: "%.4f", Date().timeIntervalSince(start)))
}

@inline(never)
func encodeSequenceIntoString<T: Sequence<UInt8>>(_ n: Int, bytes: T) {
  let start = Date()

  for _ in 0 ..< n {
    _ = bytes.hexEncodedString()
  }

  print("\`Sequence.hexEncodedString()\` | " + String(format: "%.4f", Date().timeIntervalSince(start)))
}

decodeData(_loop, hexData: _hexData)
decodeString(_loop, hexString: _hexString)
encodeCollectionIntoData(_loop, bytes: _bytes)
encodeCollectionIntoString(_loop, bytes: _bytes)
encodeSequenceIntoData(_loop, bytes: _bytes)
encodeSequenceIntoString(_loop, bytes: _bytes)
EOF

swift package clean
swift run -c release
