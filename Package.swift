// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MerchantKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_14)
    ],
    products: [
        .library(
            name: "MerchantKit",
            targets: ["MerchantKit"]
        )
    ],
    targets: [
        .target(
            name: "MerchantKit",
            path: "Sources/MerchantKit",
            resources: [
                .process("Internal/Resources")
            ]
        )
    ]
)
