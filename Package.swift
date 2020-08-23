// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Hyperconnectivity",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13),
        .macOS(.v10_15),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "Hyperconnectivity",
            targets: ["Hyperconnectivity"]
        )
    ],
    targets: [
        .target(
            name: "Hyperconnectivity",
            path: "Hyperconnectivity/Classes"
        )
    ]
)
