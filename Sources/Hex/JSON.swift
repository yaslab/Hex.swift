import Foundation

extension JSONDecoder.DataDecodingStrategy {
    public static let base16 = JSONDecoder.DataDecodingStrategy.custom { decoder in
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        guard let data = Data(hexEncoded: string) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid Base-16 string.")
        }
        return data
    }
}

extension JSONEncoder.DataEncodingStrategy {
    public static let base16 = JSONEncoder.DataEncodingStrategy.custom { data, encoder in
        var container = encoder.singleValueContainer()
        try container.encode(data.hexEncodedString())
    }
}
