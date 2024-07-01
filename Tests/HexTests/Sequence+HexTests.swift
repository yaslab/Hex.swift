import Foundation
import Hex
import Testing

struct SequenceHexTests {
    @Test func encodeByteArray() {
        // Arrange
        let bytes: [UInt8] = [0x00, 0x01, 0xfe, 0xff]

        // Act
        let hexString = bytes.hexEncodedString()

        // Assert
        #expect(hexString == "0001feff")
    }

    @Test func encodeStringData() {
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
}
