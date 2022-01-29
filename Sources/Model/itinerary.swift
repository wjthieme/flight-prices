//  Copyright © 2021 Wilhelm Thieme

import Foundation

struct Itenerary: Codable {
    let connections: [Connection]
    let flightProducts: [FlightProduct]
}
