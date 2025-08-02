import Foundation

extension Sequence<UInt8> {
    /// Returns the Hexadecimal (also known as Base-16) encoded data.
    ///
    /// - Parameter options: Encoding options. Default value is `[]`.
    @inlinable
    public func hexEncodedData(options: Base16.EncodingOptions = []) -> Data {
        let seq = Base16EncodingSequence(sequence: self, options: options)
        return Data(seq)
    }

    /// Returns the Hexadecimal (also known as Base-16) encoded string.
    ///
    /// - Parameter options: Encoding options. Default value is `[]`.
    @inlinable
    public func hexEncodedString(options: Base16.EncodingOptions = []) -> String {
        let seq = Base16EncodingSequence(sequence: self, options: options)

        if #available(iOS 18.0, macOS 15.0, tvOS 18.0, visionOS 2.0, watchOS 11.0, *) {
            return String(validating: seq, as: UTF8.self).unsafelyUnwrapped
        }

        return String(bytes: seq, encoding: .utf8).unsafelyUnwrapped
    }
}

@usableFromInline
struct Base16EncodingSequence<S: Sequence<UInt8>>: Sequence {
    private let sequence: S
    private let options: Base16.EncodingOptions

    @usableFromInline
    init(sequence: S, options: Base16.EncodingOptions) {
        self.sequence = sequence
        self.options = options
    }

    @usableFromInline
    struct Iterator: IteratorProtocol {
        private var it: S.Iterator
        private let options: Base16.EncodingOptions

        private var lower: UInt8?

        @usableFromInline
        init(it: S.Iterator, options: Base16.EncodingOptions) {
            self.it = it
            self.options = options
        }

        @usableFromInline
        mutating func next() -> UInt8? {
            if let low = lower {
                lower = nil
                return low
            }

            guard let byte = it.next() else {
                return nil
            }

            let pair = Base16.encode(byte, options: options)
            lower = pair.lower
            return pair.upper
        }
    }

    @usableFromInline
    func makeIterator() -> Iterator {
        Iterator(it: sequence.makeIterator(), options: options)
    }
}
