//  Copyright © 2021 Wilhelm Thieme

import Foundation
import ArgumentParser

struct Passenger: Codable {
    let id: Int
    let type: PassengerType

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
