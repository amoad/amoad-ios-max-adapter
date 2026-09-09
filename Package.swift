// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "AMoAdMaxAdapter",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "AMoAdMaxAdapter", targets: ["AMoAdMaxAdapterTarget"])
    ],
    dependencies: [
        // AMoAd SDK の SPM 対応バージョン以降を要求する
        .package(url: "https://github.com/amoad/amoad-ios-sdk", from: "6.3.1"),
        .package(url: "https://github.com/AppLovin/AppLovin-MAX-Swift-Package", from: "13.0.0")
    ],
    targets: [
        // xcframework は ultima-ios-sdk の make.sh maxadapter がリリースごとに配置する
        .binaryTarget(
            name: "AMoAdMaxAdapter",
            path: "AMoAdMaxAdapter.xcframework"
        ),
        // binaryTarget には依存を宣言できないため、このターゲットで
        // AMoAd SDK と AppLovinSDK への依存を束ねる
        .target(
            name: "AMoAdMaxAdapterTarget",
            dependencies: [
                "AMoAdMaxAdapter",
                .product(name: "AMoAd", package: "amoad-ios-sdk"),
                .product(name: "AppLovinSDK", package: "AppLovin-MAX-Swift-Package")
            ],
            path: "Sources/AMoAdMaxAdapterTarget"
        )
    ]
)
