//  Copyright © 2021 Wilhelm Thieme

import Foundation

struct Destination: Codable {
    let airport: Location?
    let city: Location?

    init(_ code: String) {
        self.airport = Location(code)
        self.city = nil
    }
}
