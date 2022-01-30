//  Copyright © 2021 Wilhelm Thieme

import Foundation

struct Segment: Codable {
    let arrivalDateTime: JustDateTime?
    let departureDateTime: JustDateTime?
    let origin: Location?
    let destination: Location?
    let marketingFlight: Flight?
    let cabin: Fare?
    let sellingClass: Fare?
    let fareBasis: Fare?
}
