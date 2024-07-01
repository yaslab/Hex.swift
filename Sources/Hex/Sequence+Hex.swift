import Foundation

extension Sequence where Element == UInt8 {
    /// Returns the Hexadecimal (also known as Base-16) encoded data.
    public func hexEncodedData() -> Data {
        hexEncodedString().data(using: .utf8)!
    }

    /// Returns the Hexadecimal (also known as Base-16) encoded string.
    public func hexEncodedString() -> String {
        reduce(into: "") { hexString, byte in
            hexString += String(format: "%02x", byte)
        }
    }
}
