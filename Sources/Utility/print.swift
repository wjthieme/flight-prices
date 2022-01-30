//  Copyright © 2021 Wilhelm Thieme
import Foundation
#if os(Linux)
import Glibc
#else
import Darwin.C
#endif

public func print(_ object: Any, terminate: Bool = true) {
    if terminate {
        Swift.print(object)
    } else {
        Swift.print(object, terminator: "  \r")
        fflush(stdout)
    }
}
