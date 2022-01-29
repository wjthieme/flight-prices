//  Copyright © 2021 Wilhelm Thieme

import Foundation

struct Connection: Codable {
    let dateInterval: String = "2022-08-01/2022-08-16"
    let origin: Airport = Airport("AMS")
    let destination: Airport = Airport("DPS")
}

struct Airport: Codable {
    let airport: Location

    init(_ airport: String) {
        self.airport = Location(airport)
    }
}

struct Location: Codable {
    let code: String

    init(_ code: String) {
        self.code = code
    }
}
