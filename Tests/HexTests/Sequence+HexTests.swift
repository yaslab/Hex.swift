#if canImport(Testing)

import Foundation
import Hex
import Testing

struct SequenceHexTests {
    @Test func encodeIntoHexData() {
        // Arrange
        let bytes: some Sequence<UInt8> = [0x00, 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef, 0xff]

        // Act
        let hexData = bytes.hexEncodedData()

        // Assert
        #expect(hexData == Data("000123456789abcdefff".utf8))
    }

    @Test func encodeIntoHexString() {
        // Arrange
        let bytes: some Sequence<UInt8> = [0x00, 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef, 0xff]

        // Act
        let hexString = bytes.hexEncodedString()

        // Assert
        #expect(hexString == "000123456789abcdefff")
    }

    @Test func encodeIntoUppercaseString() throws {
        // Arrange
        let bytes: some Sequence<UInt8> = [0x00, 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef, 0xff]

        // Act
        let hexString = bytes.hexEncodedString(options: .uppercase)

        // Assert
        #expect(hexString == "000123456789ABCDEFFF")
    }

    @Test func encodeFoobar() throws {
        // Arrange
        let data: some Sequence<UInt8> = Data("foobar".utf8)

        // Act
        let hexString = data.hexEncodedString(options: .uppercase)

        // Assert
        #expect(hexString == "666F6F626172")
    }

    @Test func encodeEmpty() {
        // Arrange
        let data: some Sequence<UInt8> = Data()

        // Act
        let hexString = data.hexEncodedString()

        // Assert
        #expect(hexString == "")
    }
}

#endif
