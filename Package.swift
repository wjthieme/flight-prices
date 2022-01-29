// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "flight-prices",
    platforms: [
        .macOS(.v10_15),
    ],
    targets: [
        .executableTarget(
            name: "Main",
            dependencies: [

            ],
            path: "Sources"),
        .testTarget(
            name: "Tests",
            dependencies: [
                "Main"
            ],
            path: "Tests"),
    ]
)
