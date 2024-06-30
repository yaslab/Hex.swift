import Foundation

extension Data {
    /// Creates data with the Hexadecimal (also known as Base-16) encoded data.
    ///
    /// - Parameter hexData: The Hexadecimal encoded data.
    public init?(hexEncoded hexData: Data) {
        guard let hexString = String(data: hexData, encoding: .utf8) else {
            return nil
        }

        self.init(hexEncoded: hexString)
    }

    /// Creates data with the Hexadecimal (also known as Base-16) encoded string.
    ///
    /// - Parameter hexString: The Hexadecimal encoded string.
    public init?(hexEncoded hexString: String) {
        var data = Data()
        var upper = true

        for char in hexString {
            guard char.isASCII, let hex = char.hexDigitValue else {
                return nil
            }

            if upper {
                // append upper 4bits
                data.append(UInt8(hex) << 4)
            } else {
                // append lower 4bits
                data[data.count - 1] += UInt8(hex)
            }

            upper.toggle()
        }

        if !upper {
            return nil
        }

        self = data
    }

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
