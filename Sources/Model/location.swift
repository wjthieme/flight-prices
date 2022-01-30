//  Copyright © 2021 Wilhelm Thieme

import Foundation

struct Location: Codable {
    let code: String?
    let name: String?

    init(_ code: String) {
        self.code = code
        self.name = nil
    }
}
