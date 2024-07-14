import Foundation

enum Base16 {
    enum DecodingResult: Equatable, Sendable {
        case emptyInput
        case error
        case hexValue(UInt8)
    }

    /// Decodes hex character into 4-bit data.
    static func decode<I: IteratorProtocol>(_ input: inout I) -> DecodingResult where I.Element == UInt8 {
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
