//  Copyright © 2021 Wilhelm Thieme

import Foundation

struct Fare: Codable {
    let numberOfSeatsAvailable: Int?
    let price: Product?
    let commercialCabin: CabinClass?
    let commercialCabinLabel: String?
    let fareBasis: FareBase?
    let segments: [FareSegment]
}

struct FareSegment: Codable {
    let cabin: FareBase?
    let sellingClass: FareBase?
    let fareBasis: FareBase?
}

struct FareBase: Codable {
    let code: String?
    let `class`: String?
}
