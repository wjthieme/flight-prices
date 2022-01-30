//  Copyright © 2021 Wilhelm Thieme

import Foundation

struct Product: Codable {
    let passengers: [Passenger]?
    let price: Price?
    let connections: [Fare]?
    let flexibilityWaiver: Bool?
    let currency: String?
    let displayType: String?
    let promotion: Promotion?
}
