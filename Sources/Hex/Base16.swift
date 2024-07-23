import Foundation

/// A Base-16 codec that translates between Byte sequence and Hexadecimal (also known as Base-16) strings.
public enum Base16 {
    /// Calculates the length of hex characters from the number of bytes.
    @inlinable
    public static func estimateEncodedCount(bytes: Int) -> Int {
        if bytes <= 0 {
            return 0
        } else {
            return bytes * 2
        }
    }

    /// Validates the length of hex characters.
    @inlinable
    public static func isValidEncodedCount(_ count: Int) -> Bool {
        (0 <= count) && count.isMultiple(of: 2)
    }

    /// Calculates the number of bytes from the length of hex characters.
    @inlinable
    public static func estimateDecodedCount(length: Int) -> Int {
        if length <= 0 {
            return 0
        } else {
            return (length - 1) / 2 + 1
        }
    }

    /// The result of one Base-16 decoding step.
    public enum DecodingResult: Equatable, Sendable {
        /// An indication that no more hex characters are available in the input.
        case emptyInput
        /// An indication of a decoding error.
        case error
        /// A decoded 8-bit data.
        case byteValue(UInt8)
    }

    /// Decodes hex characters into 8-bit data.
    @inlinable
    public static func decode(_ input: inout some IteratorProtocol<UInt8>) -> DecodingResult {
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

        return .byteValue((upper << 4) | lower)
    }

    /// Options to use when encoding hex characters.
    public struct EncodingOptions: OptionSet, Sendable {
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }

        /// Make letters uppercase.
        public static let uppercase = EncodingOptions(rawValue: 1 << 0)
    }

    /// Encodes 8-bit data into hex characters.
    @inlinable
    public static func encode(_ input: UInt8, options: EncodingOptions = []) -> (upper: UInt8, lower: UInt8) {
        func char(from hex: UInt8) -> UInt8 {
            if 0 <= hex, hex <= 9 {
                return 0x30 + hex  // '0'-'9'
            } else if options.contains(.uppercase) {
                return 0x41 + hex - 10  // 'A'-'F'
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
