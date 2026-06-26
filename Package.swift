// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "ApplicationDelegate",
    platforms: [
        .macOS(.v10_15), .iOS(.v14), .tvOS(.v14), .watchOS(.v7), .visionOS(.v1)
    ],
    products: [
        .library(
            name: "ApplicationDelegate",
            targets: ["ApplicationDelegate"])
    ],
    targets: [
        .target(
            name: "ApplicationDelegate",
            dependencies: [],
            swiftSettings: [
                .swiftLanguageMode(.v6)
            ]
        ),
        .testTarget(
            name: "ApplicationDelegateTests",
            dependencies: ["ApplicationDelegate"],
            swiftSettings: [
                .swiftLanguageMode(.v6)
            ]
        )
    ]
)
