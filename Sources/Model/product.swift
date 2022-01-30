//  Copyright © 2021 Wilhelm Thieme

import Foundation

struct Product: Codable {
    let passengers: [Passenger]
    let price: Price
}
