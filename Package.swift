// swift-tools-version:5.7
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
    dependencies: [
        .package(url: "https://github.com/AliSoftware/OHHTTPStubs", from: "9.1.0")
    ],
    targets: [
        .target(
            name: "Hyperconnectivity",
            path: "Hyperconnectivity/Classes"
        ),
        .testTarget(
            name: "HyperconnectivityTests",
            dependencies: [
                .target(name: "Hyperconnectivity"),
                .product(name: "OHHTTPStubsSwift", package: "OHHTTPStubs")
            ],
            path: "Example/Tests",
            resources: [
                .process("failure-response.html"),
                .process("string-contains-response.html"),
                .process("string-equality-response.html")
            ]
        )
    ]
)
