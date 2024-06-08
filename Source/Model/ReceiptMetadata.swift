import Foundation

public struct ReceiptMetadata : Equatable, Codable {
    public let originalApplicationVersion: String
    public let bundleIdentifier: String
    public let creationDate: Date?
    public let purchaseDate: Date?
    public let originalPurchaseDate: Date?
    public let cancellationDate: Date?
    public let subscriptionExpirationDate: Date?
    public let originalTransactionId: String?
    public let cancellationReason: String?

    public init(originalApplicationVersion: String = "", bundleIdentifier: String = "", creationDate: Date? = nil, purchaseDate: Date? = nil, originalPurchaseDate: Date? = nil, cancellationDate: Date? = nil, originalTransactionId: String? = nil, cancellationReason: String? = nil,     subscriptionExpirationDate: Date? = nil) {
        self.originalApplicationVersion = originalApplicationVersion
        self.bundleIdentifier = bundleIdentifier
        self.creationDate = creationDate
        self.purchaseDate = purchaseDate
        self.originalPurchaseDate = originalPurchaseDate
        self.cancellationDate = cancellationDate
        self.originalTransactionId = originalTransactionId
        self.cancellationReason = cancellationReason
        self.subscriptionExpirationDate = subscriptionExpirationDate
    }
    
    public var description: String {
        return "originalApplicationVersion: \(originalApplicationVersion) | bundleIdentifier: \(bundleIdentifier) | creationDate: \(String(describing: creationDate)) | purchaseDate: \(String(describing: purchaseDate)) | originalPurchaseDate: \(String(describing: originalPurchaseDate)) | cancellationDate: \(String(describing: cancellationDate)) | originalTransactionId: \(originalTransactionId ?? "") | cancellationReason: \(cancellationReason ?? "") || subscriptionExpirationDate: \(String(describing: subscriptionExpirationDate))"
    }

}
