//  Copyright © 2021 Wilhelm Thieme

import Foundation

struct LowestFare: Endpoint {
    typealias Request = LowestFareRequest
    typealias Response = LowestFareResponse
    let endpoint = "/opendata/offers/v1/lowest-fare-offers"
    var payload: LowestFareRequest

    init() {
        payload = LowestFareRequest()
    }

}

struct LowestFareRequest: Encodable {
    let type: LowestFareType = .day
    let commercialCabins: [CabinClass] = [.business]
    let bookingFlow: BookingFlow = .leisure
    let passengers: [Passenger] = [Passenger()]
    let requestedConnections: [Connection] = [Connection()]
}

struct LowestFareResponse: Decodable {
    let disclaimer: Disclaimer
    let itineraries: [Itenerary]
}
