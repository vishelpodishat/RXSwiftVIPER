// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

import PackageDescription

let package = Package(
  name: "RxProject",
  dependencies: [
    .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0"))
  ],
  targets: [
    .target(name: "RxProject", dependencies: ["RxSwift", .product(name: "RxCocoa", package: "RxSwift")]),
  ]
)