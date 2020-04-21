// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "MarvelClient",
    products: [
        .library(name: "MarvelClient", targets: ["MarvelClient"])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .exact("4.9.0")),
    ],
    targets: [
        .target(name: "MarvelClient", dependencies: [
          "Alamofire",
        ], path: "Sources")
    ]
)
