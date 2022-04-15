// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "LBJCodeSnippets",
  platforms: [.iOS(.v11)],
  products: [
    .library(
      name: "LBJCodeSnippets",
      targets: ["LBJCodeSnippets"]
    )
  ],
  targets: [
    .target(
      name: "LBJCodeSnippets",
      dependencies: []),
    .testTarget(
      name: "LBJCodeSnippetsTests",
      dependencies: ["LBJCodeSnippets"]
    )
  ]
)
