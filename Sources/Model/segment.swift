//  Copyright © 2021 Wilhelm Thieme

import Foundation

struct Segment: Codable {
    let arrivalDateTime: JustDateTime
    let departureDateTime: JustDateTime
    let origin: Location
    let destination: Location
    let marketingFlight: Flight

}
