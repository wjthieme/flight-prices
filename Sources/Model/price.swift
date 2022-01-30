//  Copyright © 2021 Wilhelm Thieme

import Foundation

struct Price: Codable {
    let displayPrice: Float
    let totalPrice: Float
    let currency: String
    let displayType: PriceType
    let surcharges: [Surcharge]
}

enum PriceType: String, Codable {
    case tax = "TAX"
    case fare = "FARE"
    case fee = "FEE"
}
