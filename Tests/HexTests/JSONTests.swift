#if canImport(Testing)

import Foundation
import Hex
import Testing

struct JSONTests {
    // MARK: JSON decoding tests

    @Test func decodeSingle() throws {
        // Arrange
        let data = Data(#""313233344a4b4c4d""#.utf8)

        let decoder = JSONDecoder()
        decoder.dataDecodingStrategy = .hex

        // Act
        let single = try decoder.decode(Data.self, from: data)

        // Assert
        #expect(single == Data("1234JKLM".utf8))
    }

    @Test func decodeObject() throws {
        // Arrange
        let data = Data(#"{"data":"313233344a4b4c4d"}"#.utf8)

        let decoder = JSONDecoder()
        decoder.dataDecodingStrategy = .hex

        struct Object: Codable {
            let data: Data
        }

        // Act
        let object = try decoder.decode(Object.self, from: data)

        // Assert
        #expect(object.data == Data("1234JKLM".utf8))
    }

    @Test func decodeArray() throws {
        // Arrange
        let data = Data(#"["313233344a4b4c4d"]"#.utf8)

        let decoder = JSONDecoder()
        decoder.dataDecodingStrategy = .hex

        // Act
        let array = try decoder.decode([Data].self, from: data)

        // Assert
        #expect(array == [Data("1234JKLM".utf8)])
    }

    @Test func decodeError() throws {
        // Arrange
        let data = Data(#""xyz""#.utf8)

        let decoder = JSONDecoder()
        decoder.dataDecodingStrategy = .hex

        #expect {
            // Act
            try decoder.decode(Data.self, from: data)
        } throws: {
            // Assert
            guard let error = $0 as? DecodingError else {
                return false
            }
            guard case .dataCorrupted(let context) = error else {
                return false
            }
            return context.debugDescription == "Invalid Base-16 string."
        }
    }

    // MARK: JSON encoding tests

    @Test func encodeSingle() throws {
        // Arrange
        let data = Data("1234JKLM".utf8)

        let encoder = JSONEncoder()
        encoder.dataEncodingStrategy = .hex

        // Act
        let string = try encoder.encode(data)

        // Assert
        #expect(String(decoding: string, as: UTF8.self) == #""313233344a4b4c4d""#)
    }

    @Test func encodeObject() throws {
        // Arrange
        let data = Data("1234JKLM".utf8)

        let encoder = JSONEncoder()
        encoder.dataEncodingStrategy = .hex

        struct Object: Codable {
            let data: Data
        }

        // Act
        let string = try encoder.encode(Object(data: data))

        // Assert
        #expect(String(decoding: string, as: UTF8.self) == #"{"data":"313233344a4b4c4d"}"#)
    }

    @Test func encodeArray() throws {
        // Arrange
        let data = Data("1234JKLM".utf8)

        let encoder = JSONEncoder()
        encoder.dataEncodingStrategy = .hex

        // Act
        let string = try encoder.encode([data])

        // Assert
        #expect(String(decoding: string, as: UTF8.self) == #"["313233344a4b4c4d"]"#)
    }
}

#endif
