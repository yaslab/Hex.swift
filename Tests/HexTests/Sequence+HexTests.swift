#if canImport(Testing)

import Foundation
import Hex
import Testing

struct SequenceHexTests {
    @Test func encodeIntoData() {
        // Arrange
        let bytes: [UInt8] = [0x00, 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef, 0xff]

        // Act
        let hexData = bytes.hexEncodedData()

        // Assert
        #expect(hexData == "000123456789abcdefff".data(using: .utf8))
    }

    @Test func encodeIntoString() {
        // Arrange
        let bytes: [UInt8] = [0x00, 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef, 0xff]

        // Act
        let hexString = bytes.hexEncodedString()

        // Assert
        #expect(hexString == "000123456789abcdefff")
    }

    @Test func encodeStringData() throws {
        // Arrange
        let data = try #require("01234JKLM".data(using: .utf8))

        // Act
        let hexString = data.hexEncodedString()

        // Assert
        #expect(hexString == "30313233344a4b4c4d")
    }

    @Test func encodeEmpty() {
        // Arrange
        let data = Data()

        // Act
        let hexString = data.hexEncodedString()

        // Assert
        #expect(hexString == "")
    }
}

#endif
