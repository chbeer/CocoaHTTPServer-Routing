// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "CocoaHTTPServer-Routing",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "CocoaHTTPServer-Routing",
            targets: ["CocoaHTTPServer-Routing"]),
    ],
    dependencies: [
        .package(url: "https://chbeer@github.com/chbeer/CocoaHTTPServer.git", from: "2.5.2"),
    ],
    targets: [
        .target(
            name: "CocoaHTTPServer-Routing",
            dependencies: ["CocoaHTTPServer"],
            path: "Classes"),
        .testTarget(
            name: "CocoaHTTPServer-RoutingTests",
            dependencies: ["CocoaHTTPServer-Routing"]),
    ]
)
