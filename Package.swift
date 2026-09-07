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
        // url / checksum はリリースごとに更新する
        // ( checksum は make.sh maxadapter が zip 生成時に出力する値を転記する )
        .binaryTarget(
            name: "AMoAdMaxAdapter",
            url: "https://github.com/amoad/amoad-ios-max-adapter/releases/download/1.1.5/AMoAdMaxAdapter.xcframework.zip",
            checksum: "RELEASE_TIME_CHECKSUM_PLACEHOLDER"
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
