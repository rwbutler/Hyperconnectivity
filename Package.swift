// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Hyperconnectivity",
    platforms: [
        .iOS("13.0")
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
