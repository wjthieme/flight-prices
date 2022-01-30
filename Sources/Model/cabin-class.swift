//  Copyright © 2021 Wilhelm Thieme

import Foundation
import ArgumentParser

enum CabinClass: String, Codable, ExpressibleByArgument {
    case economy = "ECONOMY"
    case peremium = "PREMIUM"
    case business = "BUSINESS"
    case first = "FIRST"
}
