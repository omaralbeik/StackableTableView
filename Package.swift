// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StackableTableView",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "StackableTableView", targets: ["StackableTableView"])
    ],
    dependencies: [],
    targets: [
        .target(name: "StackableTableView", path: "Sources")
    ]
)
