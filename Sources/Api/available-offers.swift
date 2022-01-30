//  Copyright © 2021 Wilhelm Thieme

import Foundation

struct AvailableOffers: Endpoint {
    typealias Request = AvailableOffersRequest
    typealias Response = AvailableOffersResponse
    let endpoint = "/opendata/offers/v1/available-offers"
    var payload: AvailableOffersRequest

    init(cabins: [CabinClass], passengers: [Passenger], route: [Route]) {
        payload = AvailableOffersRequest(cabins: cabins, passengers: passengers, route: route)
    }
}

struct AvailableOffersRequest: Encodable {
    let commercialCabins: [CabinClass]
    let passengers: [Passenger]
    let requestedConnections: [Route]

    init(cabins: [CabinClass], passengers: [Passenger], route: [Route]) {
        self.commercialCabins = cabins
        self.passengers = passengers
        self.requestedConnections = route
    }
}

struct AvailableOffersResponse: Decodable {
    let disclaimer: Disclaimer
    let itineraries: [Itinerary]
}
