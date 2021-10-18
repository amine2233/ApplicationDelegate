// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "ApplicationDelegate",
    platforms: [
        .macOS(.v10_15), .iOS(.v14), .tvOS(.v14), .watchOS(.v7)
    ],
    products: [
        .library(
            name: "ApplicationDelegate",
            targets: ["ApplicationDelegate"])
    ],
    targets: [
        .target(
            name: "ApplicationDelegate",
            dependencies: []
        ),
        .testTarget(
            name: "ApplicationDelegateTests",
            dependencies: ["ApplicationDelegate"])
    ]
)
