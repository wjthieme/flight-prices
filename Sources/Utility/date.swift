//  Copyright © 2021 Wilhelm Thieme

import Foundation
import ArgumentParser

public class PartialDate: Codable, ExpressibleByArgument, CustomStringConvertible {
    public var description: String { return Self.dateFormatter.string(from: date) }
    fileprivate class var format: String { "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" }
    fileprivate class var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }

    fileprivate let date: Date

    public required init(_ date: Date = Date()) {
        self.date = date
    }

    public required init(_ other: PartialDate) {
        self.date = other.date
    }

    required public init?(argument: String) {
        guard let date = Self.dateFormatter.date(from: argument) else { return nil }
        self.date = date
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)
        guard let date = Self.dateFormatter.date(from: stringValue) else { throw DateError.invalidFormat(string: stringValue) }
        self.date = date
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let stringValue = Self.dateFormatter.string(from: date)
        try container.encode(stringValue)
    }

    public func addingDays(_ days: Int) -> Self {
        let interval = Double(days * 86400)
        let newDate = date.addingTimeInterval(interval)
        return Self.init(newDate)
    }

    public func days(since other: PartialDate) -> Int {
        let interval = date.timeIntervalSince(other.date)
        return Int(interval) / 86400
    }
}

public class JustDate: PartialDate {
    override class var format: String { "YYYY-MM-dd" }
}

public class JustTime: PartialDate {
    override class var format: String { "HH:mm:ss" }
}

public class JustDateTime: PartialDate {
    override class var format: String { "YYYY-MM-dd'T'HH:mm:ss" }
}

enum DateError: EnumError {
    case invalidFormat(string: String)
}
