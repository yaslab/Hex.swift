import Foundation

/// A Base-16 codec that translates between Byte sequence and Hexadecimal (also known as Base-16) strings.
enum Base16 {
    /// The result of one Base-16 decoding step.
    enum DecodingResult: Sendable {
        /// An indication that no more hex characters are available in the input.
        case emptyInput
        /// An indication of a decoding error.
        case error
        /// A decoded hex value.
        case hexValue(UInt8)
    }

    /// Decodes hex characters into 8-bit data.
    static func decode(_ input: inout some IteratorProtocol<UInt8>) -> DecodingResult {
        func hex(from char: UInt8) -> UInt8? {
            if 0x30 <= char, char <= 0x39 {  // '0'-'9'
                return char - 0x30
            } else if 0x41 <= char, char <= 0x46 {  // 'A'-'F'
                return char - 0x41 + 10
            } else if 0x61 <= char, char <= 0x66 {  // 'a'-'f'
                return char - 0x61 + 10
            }
            return nil
        }

        guard let char0 = input.next() else {
            return .emptyInput
        }
        guard let upper = hex(from: char0) else {
            return .error
        }

        guard let char1 = input.next() else {
            return .error
        }
        guard let lower = hex(from: char1) else {
            return .error
        }

        return .hexValue((upper << 4) | lower)
    }

    /// Encodes 8-bit data into hex characters.
    static func encode(_ input: UInt8) -> (upper: UInt8, lower: UInt8) {
        func char(from hex: UInt8) -> UInt8 {
            if 0 <= hex, hex <= 9 {
                return 0x30 + hex  // '0'-'9'
            } else {
                return 0x61 + hex - 10  // 'a'-'f'
            }
        }

        return (
            upper: char(from: input >> 4),
            lower: char(from: input & 0b1111)
        )
    }
}
