//  Copyright © 2021 Wilhelm Thieme

import Foundation
import ArgumentParser

struct LookupCommand: SubCommand {
    static let configuration = CommandConfiguration(
        commandName: "reference",
        abstract: "Find a reference fare for a given route."
    )

    @Option(name: .shortAndLong, help: "IATA code for the origin airport.")
    var origin: String = "AMS"

    @Option(name: .shortAndLong, help: "IATA code for the destination airport.")
    var destination: String = "CDG"

    @Option(name: .shortAndLong, parsing: .upToNextOption, help: "The passengers for this trip.")
    var travellers: [PassengerType] = [.adult]

    @Option(name: .shortAndLong, help: "The cabin class for this trip.")
    var cabinClass: CabinClass = .economy

    func validate() throws {
        if travellers.isEmpty { throw ValidationError("Travellers cannot be empty.") }
    }

    func run() throws {
        print("Finding a reference fare for flights from \(origin) to \(destination):")
        let outboundFlight = Connection(origin: origin, destination: destination)
        let inboundFlight = Connection(origin: destination, destination: origin)
        let endpoint = LowestFare(cabins: [cabinClass], passengers: travellers.passengers, route: [outboundFlight, inboundFlight])
        let response = try api.request(endpoint)
        guard let itinerary = response.itineraries.min(by: { $0.price < $1.price }) else { throw ReferenceError.noReferencePriceFound() }
        printFlights(in: itinerary)
    }

    private func printFlights(in itinerary: Itinerary) {
        let flights = itinerary.connections ?? []
        let fares = itinerary.flightProducts?.flatMap({ $0.connections?.compactMap({ $0 }) ?? [] }) ?? []
        let amount = min(flights.count, fares.count)
        for n in 0..<amount {
            let departure = flights[n].departureDate ?? JustDate(.distantPast)
            let origin = flights[n].origin?.airport?.code ?? ""
            let destination = flights[n].destination?.airport?.code ?? ""
            let duration = flights[n].duration ?? 0
            let fare = fares[n].fareBasis?.code ?? ""
            let seats = fares[n].numberOfSeatsAvailable == 0 ? "NO SEATS" : ""
            print("\(departure): \(origin) -(\(duration))> \(destination) (\(fare)) \(seats)")
        }
        print("\(itinerary.price)EUR")
    }
}

enum ReferenceError: EnumError {
    case noReferencePriceFound(Void = ())
}
