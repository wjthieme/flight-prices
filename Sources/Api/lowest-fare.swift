//  Copyright © 2021 Wilhelm Thieme

import Foundation

struct LowestFare: Endpoint {
    typealias Request = LowestFareRequest
    typealias Response = LowestFareResponse
    let endpoint = "/opendata/offers/v1/lowest-fare-offers"
    var payload: LowestFareRequest

    init(cabins: [CabinClass], passengers: [Passenger], route: [Connection]) {
        payload = LowestFareRequest(cabins: cabins, passengers: passengers, route: route)
    }
}

struct LowestFareRequest: Encodable {
    let type: LowestFareType = .overall
    let commercialCabins: [CabinClass]
    let passengers: [Passenger]
    let requestedConnections: [Connection]

    init(cabins: [CabinClass], passengers: [Passenger], route: [Connection]) {
        self.commercialCabins = cabins
        self.passengers = passengers
        self.requestedConnections = route
    }
}

struct LowestFareResponse: Decodable {
    let disclaimer: Disclaimer
    let itineraries: [Itinerary]
}

enum LowestFareType: String, Codable {
    case overall = "OVERALL"
    case month = "MONTH"
    case day = "DAY"
}
