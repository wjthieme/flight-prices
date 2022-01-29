// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "flight-prices",
    platforms: [
        .macOS(.v10_15),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.2"),
    ],
    targets: [
        .executableTarget(
            name: "FlightPrices",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            path: "Sources"),
        .testTarget(
            name: "Tests",
            dependencies: [
                .target(name: "FlightPrices")
            ],
            path: "Tests"),
    ]
)
