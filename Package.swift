// swift-tools-version:4.1
import PackageDescription

let package = Package(
    name: "ApplicationDelegate",
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
