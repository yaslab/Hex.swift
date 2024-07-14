import Foundation

extension Data {
    /// Creates data with the Hexadecimal (also known as Base-16) encoded data.
    ///
    /// - Parameter hexData: The Hexadecimal encoded data.
    public init?(hexEncoded hexData: Data) {
        guard let bytes = Data.decode(hexData) else {
            return nil
        }
        self = Data(bytes)
    }

    /// Creates data with the Hexadecimal (also known as Base-16) encoded string.
    ///
    /// - Parameter hexString: The Hexadecimal encoded string.
    public init?(hexEncoded hexString: String) {
        var hexString = hexString
        guard let bytes = hexString.withUTF8(Data.decode(_:)) else {
            return nil
        }
        self = Data(bytes)
    }

    private static func decode<S: Sequence>(_ input: S) -> [UInt8]? where S.Element == UInt8 {
        var bytes = [UInt8]()
        var it = input.makeIterator()
        while true {
            switch Base16.decode(&it) {
            case .emptyInput:
                return bytes
            case .error:
                return nil
            case .hexValue(let byte):
                bytes.append(byte)
            }
        }
    }
}
