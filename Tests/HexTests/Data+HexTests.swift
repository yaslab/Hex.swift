#if compiler(>=6.0)

import Foundation
import Hex
import Testing

struct DataHexTests {
    @Test func decodeHexData() throws {
        // Arrange
        let hexData = Data("000123456789abcdefFF".utf8)

        // Act
        let data = try #require(Data(hexEncoded: hexData))

        // Assert
        #expect(data == Data([0x00, 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef, 0xff]))
    }

    @Test func decodeHexString() throws {
        // Arrange
        let hexString = "000123456789abcdefff"

        // Act
        let data = try #require(Data(hexEncoded: hexString))

        // Assert
        #expect(data == Data([0x00, 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef, 0xff]))
    }

    @Test func decodeUppercaseString() throws {
        // Arrange
        let hexString = "000123456789ABCDEFFF"

        // Act
        let data = try #require(Data(hexEncoded: hexString))

        // Assert
        #expect(data == Data([0x00, 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef, 0xff]))
    }

    @Test func decodeFoobar() throws {
        // Arrange
        let hexString = "666F6F626172"

        // Act
        let data = try #require(Data(hexEncoded: hexString))

        // Assert
        #expect(String(decoding: data, as: UTF8.self) == "foobar")
    }

    @Test func decodeEmpty() throws {
        // Arrange
        let hexString = ""

        // Act
        let data = try #require(Data(hexEncoded: hexString))

        // Assert
        #expect(data.isEmpty)
    }

    @Test func decodeOneDigitData() {
        // Arrange
        let hexData = Data("4".utf8)

        // Act
        let data = Data(hexEncoded: hexData)

        // Assert
        #expect(data == nil)
    }

    @Test func decodeOneDigitString() {
        // Arrange
        let hexString = "4"

        // Act
        let data = Data(hexEncoded: hexString)

        // Assert
        #expect(data == nil)
    }

    @Test func decodeTwoDigitString() throws {
        // Arrange
        let hexString = "4D"

        // Act
        let data = try #require(Data(hexEncoded: hexString))

        // Assert
        #expect(String(decoding: data, as: UTF8.self) == "M")
    }

    @Test func decodeNonASCIIString() {
        // Arrange
        let hexString = "4Ｄ"

        // Act
        let data = Data(hexEncoded: hexString)

        // Assert
        #expect(data == nil)
    }

    @Test func decodeNonHexData() {
        // Arrange
        let hexData = Data("G0".utf8)

        // Act
        let data = Data(hexEncoded: hexData)

        // Assert
        #expect(data == nil)
    }

    @Test func decodeNonHexString() {
        // Arrange
        let hexString = "0G"

        // Act
        let data = Data(hexEncoded: hexString)

        // Assert
        #expect(data == nil)
    }
}

#endif
