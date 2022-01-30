//  Copyright © 2021 Wilhelm Thieme

import Foundation

struct Connection: Codable {
    let duration: Int?
    let segments: [Segment]?
    let origin: Destination?
    let destination: Destination?
    let departureDate: JustDate?

    init(origin: String, destination: String, date: JustDate? = nil) {
        self.origin = Destination(origin)
        self.destination = Destination(destination)
        self.departureDate = date
        self.duration = nil
        self.segments = nil
    }
}
