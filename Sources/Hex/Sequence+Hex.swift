import Foundation

extension Sequence<UInt8> {
    /// Returns the Hexadecimal (also known as Base-16) encoded data.
    public func hexEncodedData(options: Base16.EncodingOptions = []) -> Data {
        Data(encode(options: options))
    }

    /// Returns the Hexadecimal (also known as Base-16) encoded string.
    public func hexEncodedString(options: Base16.EncodingOptions = []) -> String {
        String(decoding: encode(options: options), as: UTF8.self)
    }

    private func encode(options: Base16.EncodingOptions) -> [UInt8] {
        reduce(into: [UInt8]()) { string, byte in
            let result = Base16.encode(byte, options: options)
            string.append(result.upper)
            string.append(result.lower)
        }
    }
}
