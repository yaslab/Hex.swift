import Foundation

extension Sequence<UInt8> {
    /// Returns the Hexadecimal (also known as Base-16) encoded data.
    public func hexEncodedData() -> Data {
        Data(encode())
    }

    /// Returns the Hexadecimal (also known as Base-16) encoded string.
    public func hexEncodedString() -> String {
        String(decoding: encode(), as: UTF8.self)
    }

    private func encode() -> [UInt8] {
        reduce(into: [UInt8]()) { string, byte in
            let result = Base16.encode(byte)
            string.append(result.upper)
            string.append(result.lower)
        }
    }
}
