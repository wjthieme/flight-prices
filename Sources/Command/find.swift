//  Copyright © 2021 Wilhelm Thieme

import Foundation
import ArgumentParser

struct FindCommand: SubCommand {
    static let configuration = CommandConfiguration(
        commandName: "find",
        abstract: "Find the lowest fare for given dates."
    )


    func run() throws {
        let response = try api.request(LowestFare())
        print(response)


    }

}
