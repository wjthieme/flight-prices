//  Copyright © 2021 Wilhelm Thieme

import Foundation

struct Flight: Codable {
    let number: String
    let carrier: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        number = try container.decode(String.self, forKey: .number)
        let inner = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .carrier)
        carrier = try inner.decode(String.self, forKey: .code)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(number, forKey: .number)
        var inner = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .carrier)
        try inner.encode(carrier, forKey: .code)
    }

    enum CodingKeys: String, CodingKey {
        case number
        case carrier
        case code
    }
}
