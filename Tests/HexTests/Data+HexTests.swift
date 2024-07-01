import Foundation
import Hex
import Testing

struct DataHexTests {
    @Test func decodeHexString() {
        // Arrange
        let hexString = "0001feff"

        // Act
        let data = Data(hexEncoded: hexString)!

        // Assert
        #expect(data == Data([0x00, 0x01, 0xfe, 0xff]))
    }

    @Test func decodeUpperCase() {
        // Arrange
        let hexString = "303132333435363738394a4b4C4D"

        // Act
        let data = Data(hexEncoded: hexString)!

        // Assert
        #expect(String(decoding: data, as: UTF8.self) == "0123456789JKLM")
    }

    @Test func decodeEmpty() {
        // Arrange
        let hexString = ""

        // Act
        let data = Data(hexEncoded: hexString)!

        // Assert
        #expect(data.isEmpty)
    }

    @Test func decodeOneDigitString() {
        // Arrange
        let hexString = "4"

        // Act
        let data = Data(hexEncoded: hexString)

        // Assert
        #expect(data == nil)
    }

    @Test func decodeTwoDigitString() {
        // Arrange
        let hexString = "4D"

        // Act
        let data = Data(hexEncoded: hexString)!

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

    @Test func decodeNonHexString() {
        // Arrange
        let hexString = "4G"

        // Act
        let data = Data(hexEncoded: hexString)

        // Assert
        #expect(data == nil)
    }
}
