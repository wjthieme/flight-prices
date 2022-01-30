//  Copyright © 2021 Wilhelm Thieme

import Foundation

struct Route: Codable {
    let origin: Destination
    let destination: Destination
    let departureDate: JustDate

    init(origin: String, destination: String, date: JustDate) {
        self.origin = Destination(origin)
        self.destination = Destination(destination)
        self.departureDate = date
    }
}
