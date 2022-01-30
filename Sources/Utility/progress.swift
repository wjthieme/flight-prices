//  Copyright © 2021 Wilhelm Thieme

import Foundation

extension Collection {

    func mapWithProgress<T>(_ block: (Element) -> T?) -> [T] {
        var result: [T?] = .init(repeating: nil, count: count)
        print(bar(0), terminate: false)
        for i in 0..<count {
            let perc = Float(i) / Float(count)
            print(bar(perc), terminate: false)
            result[i] = block(self[index(startIndex, offsetBy: i)])
        }
        return result.compactMap({ $0 })
    }

    private func bar(_ perc: Float, length: Int = 25) -> String {
        let filledLength = Int(perc * Float(length))
        let unfilled = [">"] + [String](repeating: " ", count: length-1)
        let filled = [String](repeating: "-", count: filledLength)
        let bar = filled + unfilled[0..<length-filledLength]
        let percentage = Int(perc * 100)
        return " [\(bar.joined())] - \(percentage)%"
    }
}
