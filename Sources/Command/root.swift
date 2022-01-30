//  Copyright © 2021 Wilhelm Thieme
import Foundation
import ArgumentParser

@main
struct RootCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "flight-prices",
        abstract: "Command line tool for getting KLM/AirFrance flight prices.",
        subcommands: [FindCommand.self, LookupCommand.self]
    )
}

protocol SubCommand: ParsableCommand {
    var verbose: Bool { get }
    var apiKey: String? { get }
    var api: Api { get }
}

extension SubCommand {
    var apiKey: String? { ProcessInfo.processInfo.environment["API_KEY"] }
    var verbose: Bool { ProcessInfo.processInfo.environment["VERBOSE_LOGGING"] == "1" }
    var api: Api { ApiImpl(apiKey, verbose: verbose) }
}
