// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "StackableTableView",
    products: [
        .library(name: "StackableTableView", targets: ["StackableTableView"])
    ],
    dependencies: [],
    targets: [
        .target(name: "StackableTableView", dependencies: [], path: "Sources")
    ]
)
