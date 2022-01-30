//  Copyright © 2021 Wilhelm Thieme

import Foundation

struct Connection: Codable {
    let duration: Int
    let segments: [Segment]
}
