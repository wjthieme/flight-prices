//  Copyright © 2021 Wilhelm Thieme

import Foundation

struct Itinerary: Codable {
    let connections: [Connection]
    let flightProducts: [Product]
}
