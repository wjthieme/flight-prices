//  Copyright © 2021 Wilhelm Thieme

import Foundation

struct Itinerary: Codable {
    let connections: [Connection]?
    let flightProducts: [Product]?

    public var price: Float {
        return flightProducts?.map({ $0.price?.totalPrice ?? .infinity }).reduce(0, +) ?? .infinity
    }
}
