#if compiler(>=6.0)

import Foundation
import Hex
import Testing

struct Base16Tests {
    // Arrange
    @Test(arguments: [
        (-1, 0),
        (0, 0),
        (1, 2),
        (2, 4),
    ])
    func estimateEncodedCount(argument: (bytes: Int, expected: Int)) {
        // Act
        let length = Base16.estimateEncodedCount(bytes: argument.bytes)

        // Assert
        #expect(length == argument.expected)
    }

    // Arrange
    @Test(arguments: [
        (-2, false),
        (-1, false),
        (0, true),
        (1, false),
        (2, true),
    ])
    func isValidEncodedCount(argument: (length: Int, expected: Bool)) {
        // Act
        let isValid = Base16.isValidEncodedCount(argument.length)

        // Assert
        #expect(isValid == argument.expected)
    }

    // Arrange
    @Test(arguments: [
        (-1, 0),
        (0, 0),
        (1, 1),
        (2, 1),
        (3, 2),
        (4, 2),
    ])
    func estimateDecodedCount(argument: (length: Int, expected: Int)) {
        // Act
        let bytes = Base16.estimateDecodedCount(length: argument.length)

        // Assert
        #expect(bytes == argument.expected)
    }

    @Test func decodeOneDigitString() {
        // Arrange
        var it = "0".utf8.makeIterator()

        // Act
        let result = Base16.decode(&it)

        // Assert
        #expect(result == .error)
    }
}

#endif
