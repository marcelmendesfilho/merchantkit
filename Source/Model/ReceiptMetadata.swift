import Foundation

public struct ReceiptMetadata : Equatable {
    public let originalApplicationVersion: String
    public let bundleIdentifier: String
    public let creationDate: Date?
    public let purchaseDate: Date?
    public let originalPurchaseDate: Date?
    public let cancelationDate: Date?

    public init(originalApplicationVersion: String = "", bundleIdentifier: String = "", creationDate: Date? = nil, purchaseDate: Date? = nil, originalPurchaseDate: Date? = nil, cancelationDate: Date? = nil) {
        self.originalApplicationVersion = originalApplicationVersion
        self.bundleIdentifier = bundleIdentifier
        self.creationDate = creationDate
        self.purchaseDate = purchaseDate
        self.originalPurchaseDate = originalPurchaseDate
        self.cancelationDate = cancelationDate
    }
}
