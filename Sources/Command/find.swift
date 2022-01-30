//  Copyright © 2021 Wilhelm Thieme

import Foundation
import ArgumentParser

struct FindCommand: SubCommand {
    static let configuration = CommandConfiguration(
        commandName: "find",
        abstract: "Find the lowest fare for a given route on given dates."
    )

    @Option(name: .shortAndLong, help: "IATA code for the origin airport.")
    var origin: String = "AMS"

    @Option(name: .shortAndLong, help: "IATA code for the destination airport.")
    var destination: String = "CDG"

    @Option(name: .shortAndLong, help: "The start date for the lookup (YYYY-MM-DD).")
    var startDate: JustDate = JustDate().addingDays(2)

    @Option(name: .shortAndLong, help: "The end date for the lookup (YYYY-MM-DD).")
    var endDate: JustDate = JustDate().addingDays(10)

    @Option(name: .shortAndLong, parsing: .upToNextOption, help: "The passengers for this trip.")
    var travellers: [PassengerType] = [.adult]

    @Option(name: .shortAndLong, help: "The cabin class for this trip.")
    var cabinClass: CabinClass = .economy

    func validate() throws {
        if travellers.isEmpty { throw ValidationError("Travellers cannot be empty.") }
    }

    func run() throws {
        let flightDates = dates()
        let flightPrices = flightDates.mapWithProgress(cheapestFlight)
        let amount = min(10, flightPrices.count)
        let indexes = flightPrices.enumerated().sorted(by: { $0.element < $1.element }).map({ $0.offset })[0..<amount]
        indexes.forEach({ print("\(flightPrices[$0])EUR \(flightDates[$0])") })
    }

    private func dates() -> [(outbound: JustDate, inbound: JustDate)] {
        let days = 0...endDate.days(since: startDate)
        return days.flatMap({ start in days.map({ end in (start, end) }) })
            .filter({ $0.0 <= $0.1 })
            .map({ (startDate.addingDays($0.0), startDate.addingDays($0.1)) })
    }

    private func cheapestFlight(outboundDate: JustDate, inboundDate: JustDate) -> Float {
        let outboundFlight = Connection(origin: origin, destination: destination, date: outboundDate)
        let inboundFlight = Connection(origin: destination, destination: origin, date: inboundDate)
        let endpoint = AvailableOffers(cabins: [cabinClass], passengers: travellers.passengers, route: [outboundFlight, inboundFlight])
        guard let response = try? api.request(endpoint) else { return Float.infinity }
        guard let cheapestItinerary = response.itineraries.min(by: { $0.price < $1.price }) else { return .infinity }
        return cheapestItinerary.price
    }

}
