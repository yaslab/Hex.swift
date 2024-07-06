# Hex.swift

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fyaslab%2FHex.swift%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/yaslab/Hex.swift)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fyaslab%2FHex.swift%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/yaslab/Hex.swift)

A library for converting between `Data` and Hexadecimal (also known as Base-16) strings.

## Usage

### Encode `Data` to Hexadecimal string

```swift
// This is the original data.
let data: Data = "0123456789JKLM".data(using: .utf8)!

// Perform encoding.
let hexString: String = data.hexEncodedString()

print(hexString)
// -> "303132333435363738394a4b4c4d"
```

### Decode Hexadecimal string to `Data`

```swift
// This is the Hexadecimal encoded string.
let hexString: String = "303132333435363738394a4b4c4d"

// Perform decoding.
let data: Data = Data(hexEncoded: hexString)!

print(String(decoding: data, as: UTF8.self))
// -> "0123456789JKLM"
```

## Installation

### Swift Package Manager

```
.package(url: "https://github.com/yaslab/Hex.swift.git", from: "1.0.0")
```

## License

Hex.swift is released under the MIT license. See the [LICENSE](https://github.com/yaslab/Hex.swift/blob/main/LICENSE) file for more info.
