//  Copyright © 2021 Wilhelm Thieme

import Foundation

public protocol EnumError: CustomNSError { }
public extension EnumError {
    var description: String { "\(Self.errorDomain): \(errorCode) \(errorInfoDescription)" }
    var errorUserInfo: [String: Any] { ["nserror-name": errorName, "nserror-info": errorInfo] }

    private var errorName: String { Mirror(reflecting: self).children.first?.label ?? "" }
    private var errorInfo: String { String(describing: Mirror(reflecting: self).children.first?.value ?? "") }
    private var errorInfoDescription: String { errorInfo == "()" ? "" : errorInfo }
}
