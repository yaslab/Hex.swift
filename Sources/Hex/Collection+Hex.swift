import Foundation

extension Collection<UInt8> {
    /// Returns the Hexadecimal (also known as Base-16) encoded data.
    ///
    /// - Parameter options: Encoding options. Default value is `[]`.
    @inlinable
    public func hexEncodedData(options: Base16.EncodingOptions = []) -> Data {
        let capacity = Base16.estimateEncodedCount(bytes: count)
        var data = Data(count: capacity)
        data.withUnsafeMutableBytes { raw in
            raw.withMemoryRebound(to: UInt8.self) { buffer in
                buffer.deinitialize()
                encode(into: buffer.baseAddress.unsafelyUnwrapped, options: options)
            }
        }
        return data
    }

    /// Returns the Hexadecimal (also known as Base-16) encoded string.
    ///
    /// - Parameter options: Encoding options. Default value is `[]`.
    @inlinable
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    public func hexEncodedString(options: Base16.EncodingOptions = []) -> String {
        let capacity = Base16.estimateEncodedCount(bytes: count)
        return String(unsafeUninitializedCapacity: capacity) { buffer in
            encode(into: buffer.baseAddress.unsafelyUnwrapped, options: options)
            return capacity
        }
    }

    @inlinable
    func encode(into output: UnsafeMutablePointer<UInt8>, options: Base16.EncodingOptions) {
        for (i, byte) in enumerated() {
            let pair = Base16.encode(byte, options: options)
            output.advanced(by: i * 2 + 0).initialize(to: pair.upper)
            output.advanced(by: i * 2 + 1).initialize(to: pair.lower)
        }
    }
}
