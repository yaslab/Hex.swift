import Foundation

extension Data {
    /// Creates data with the Hexadecimal (also known as Base-16) encoded data.
    ///
    /// - Parameter hexData: The Hexadecimal encoded data.
    public init?(hexEncoded hexData: Data) {
        let bytes = hexData.withUnsafeBytes { raw in
            raw.withMemoryRebound(to: UInt8.self, Data.decode(_:))
        }
        guard let bytes else {
            return nil
        }
        self = bytes
    }

    /// Creates data with the Hexadecimal (also known as Base-16) encoded string.
    ///
    /// - Parameter hexString: The Hexadecimal encoded string.
    public init?(hexEncoded hexString: String) {
        var hexString = hexString
        guard let bytes = hexString.withUTF8(Data.decode(_:)) else {
            return nil
        }
        self = bytes
    }

    private static func decode(_ input: UnsafeBufferPointer<UInt8>) -> Data? {
        guard Base16.isValidEncodedCount(input.count) else {
            return nil
        }

        let capacity = Base16.estimateDecodedCount(length: input.count)
        var bytes = Data(count: capacity)
        let count = bytes.withUnsafeMutableBytes { raw in
            raw.withMemoryRebound(to: UInt8.self) { buffer in
                buffer.deinitialize()

                var i = 0
                var it = input.makeIterator()
                let output = buffer.baseAddress.unsafelyUnwrapped
                while true {
                    switch Base16.decode(&it) {
                    case .emptyInput:
                        return i
                    case .error:
                        return -1
                    case .byteValue(let byte):
                        output.advanced(by: i).initialize(to: byte)
                        i += 1
                    }
                }
            }
        }

        guard count == capacity else {
            return nil
        }

        return bytes
    }
}
