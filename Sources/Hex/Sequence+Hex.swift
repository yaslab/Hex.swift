import Foundation

extension Sequence<UInt8> {
    /// Returns the Hexadecimal (also known as Base-16) encoded data.
    ///
    /// - Parameter options: Encoding options. Default value is `[]`.
    @inlinable
    public func hexEncodedData(options: Base16.EncodingOptions = []) -> Data {
        Data(EncoderSequence(sequence: self, options: options))
    }

    /// Returns the Hexadecimal (also known as Base-16) encoded string.
    ///
    /// - Parameter options: Encoding options. Default value is `[]`.
    @inlinable
    public func hexEncodedString(options: Base16.EncodingOptions = []) -> String {
        String(bytes: EncoderSequence(sequence: self, options: options), encoding: .utf8)!
    }
}

@usableFromInline
struct EncoderSequence<S: Sequence<UInt8>>: Sequence {
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
