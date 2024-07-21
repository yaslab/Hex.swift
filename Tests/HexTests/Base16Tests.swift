#if canImport(Testing)

import Foundation
import Hex
import Testing

struct Base16Tests {
    @Test(
        // Arrange
        arguments: [
            (-2, false),
            (-1, false),
            (0, true),
            (1, false),
            (2, true),
        ]
    )
    func isValidCount(argument: (count: Int, expected: Bool)) {
        // Act
        let isValid = Base16.isValidCount(argument.count)

        // Assert
        #expect(isValid == argument.expected)
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
