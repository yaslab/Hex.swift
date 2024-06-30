import Testing
import Foundation
import Hex

struct HexTests {
    @Test func encode() {
        // Arrange
        let data = "0123456789JKLM".data(using: .utf8)!

        // Act
        let hexString = data.hexEncodedString()

        // Assert
        #expect(hexString == "303132333435363738394a4b4c4d")
    }

    @Test func encodeEmpty() {
        // Arrange
        let data = Data()

        // Act
        let hexString = data.hexEncodedString()

        // Assert
        #expect(hexString == "")
    }

    @Test func decode() {
        // Arrange
        let hexString = "303132333435363738394a4b4C4D"
        
        // Act
        let data = Data(hexEncoded: hexString)!
        let string = String(decoding: data, as: UTF8.self)

        // Assert
        #expect(string == "0123456789JKLM")
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
        let string = String(decoding: data, as: UTF8.self)

        // Assert
        #expect(string == "M")
    }

    @Test func decodeNonASCIIString() {
        // Arrange
        let hexString = "4Ｄ"
        
        // Act
        let data = Data(hexEncoded: hexString)

        // Assert
        #expect(data == nil)
    }
}
