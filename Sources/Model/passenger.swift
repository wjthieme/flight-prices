//  Copyright © 2021 Wilhelm Thieme

import Foundation
import ArgumentParser

struct Passenger: Codable {
    let id: Int?
    let type: PassengerType?

    init(id: Int, type: PassengerType) {
        self.id = id
        self.type = type
    }
}

enum PassengerType: String, Codable, ExpressibleByArgument {
    case adult = "ADT"
    case child = "CHD"
    case infant = "INF"
    case teen = "YTH"
    case senior = "YCD"
}

extension Array where Element == PassengerType {
    var passengers: [Passenger] {
        return (0..<count).map({ Passenger(id: $0, type: self[$0]) })
    }
}
