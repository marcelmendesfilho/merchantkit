import Foundation

public struct ReceiptMetadata : Equatable {
    public let originalApplicationVersion: String
    public let bundleIdentifier: String
    public let creationDate: Date?
    public let purchaseDate: Date?
    public let originalPurchaseDate: Date?
    public let cancelationDate: Date?
    public let originalTransactionId: String?
    public let cancellationReason: String?

    public init(originalApplicationVersion: String = "", bundleIdentifier: String = "", creationDate: Date? = nil, purchaseDate: Date? = nil, originalPurchaseDate: Date? = nil, cancelationDate: Date? = nil, originalTransactionId: String? = nil, cancellationReason: String? = nil) {
        self.originalApplicationVersion = originalApplicationVersion
        self.bundleIdentifier = bundleIdentifier
        self.creationDate = creationDate
        self.purchaseDate = purchaseDate
        self.originalPurchaseDate = originalPurchaseDate
        self.cancelationDate = cancelationDate
        self.originalTransactionId = originalTransactionId
        self.cancellationReason = cancellationReason
    }
    
    public var description: String {
        return "originalApplicationVersion: \(originalApplicationVersion) | bundleIdentifier: \(bundleIdentifier) | creationDate: \(String(describing: creationDate)) | purchaseDate: \(String(describing: purchaseDate)) | originalPurchaseDate: \(String(describing: originalPurchaseDate)) | cancelationDate: \(String(describing: cancelationDate)) | originalTransactionId: \(originalTransactionId ?? "") | cancellationReason: \(cancellationReason ?? "")"
    }

}
