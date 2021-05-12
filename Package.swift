// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Shari",
    platforms: [.iOS(.v10)],
    products: [.library(name: "Shari", targets: ["Shari"])],
    targets: [.target(name: "Shari", path: "Sources")]
)
