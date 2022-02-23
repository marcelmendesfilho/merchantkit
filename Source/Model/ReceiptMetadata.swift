import Foundation

public struct ReceiptMetadata : Equatable {
    public let originalApplicationVersion: String
    public let bundleIdentifier: String
    public let creationDate: Date?
    public let purchaseDate: Date?
    public let originalPurchaseDate: Date?
    public let cancelationDate: Date?
    public let originalTransactionId: String?

    public init(originalApplicationVersion: String = "", bundleIdentifier: String = "", creationDate: Date? = nil, purchaseDate: Date? = nil, originalPurchaseDate: Date? = nil, cancelationDate: Date? = nil, originalTransactionId: String? = nil) {
        self.originalApplicationVersion = originalApplicationVersion
        self.bundleIdentifier = bundleIdentifier
        self.creationDate = creationDate
        self.purchaseDate = purchaseDate
        self.originalPurchaseDate = originalPurchaseDate
        self.cancelationDate = cancelationDate
        self.originalTransactionId = originalTransactionId
    }
    
    public var description: String {
        return self.defaultDescription(withProperties: ("originalApplicationVersion", self.originalApplicationVersion), ("bundleIdentifier", self.bundleIdentifier ?? "nil"), ("creationDate", self.creationDate ?? "nil"), ("purchaseDate", self.purchaseDate ?? "nil"), ("originalPurchaseDate", self.originalPurchaseDate ?? "nil"), ("cancelationDate", self.cancelationDate ?? "nil"), ("originalTransactionId", self.originalTransactionId ?? "nil"))
    }

}
