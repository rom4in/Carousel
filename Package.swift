// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Carousel",
    platforms: [.iOS(.v13), .macOS(.v11)],
    products: [ .library( name: "Carousel",  targets: ["Carousel"])],
    targets: [.target(name: "Carousel")]
)
