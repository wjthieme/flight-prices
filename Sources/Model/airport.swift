//  Copyright © 2021 Wilhelm Thieme

import Foundation

struct Destination: Codable {
    let airport: Location

    init(_ code: String) {
        self.airport = Location(code)
    }
}

struct Location: Codable {
    let code: String

    init(_ code: String) {
        self.code = code
    }
}


