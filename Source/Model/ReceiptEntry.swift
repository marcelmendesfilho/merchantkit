import Foundation

/// A `ReceiptEntry` represents the pertinent information for a product contained within a `StoreKit` receipt.
public struct ReceiptEntry : CustomStringConvertible { // Ideally, this would be Receipt.Entry
    /// The product identifier for a purchase.
    public let productIdentifier: String
    /// The expiry date for a subscription purchase, if available.
    public let expiryDate: Date?
    /// The purchase date
    public let purchaseDate: Date?
    /// The original purchase date
    public let originalPurchaseDate: Date?
    /// Cancelation date, if available
    public let cancelationDate: Date?
    
    public init(productIdentifier: String, expiryDate: Date?, purchaseDate: Date?, originalPurchaseDate: Date?, cancelationDate: Date?) {
        self.productIdentifier = productIdentifier
        self.expiryDate = expiryDate
        self.purchaseDate = purchaseDate
        self.originalPurchaseDate = originalPurchaseDate
        self.cancelationDate = cancelationDate
    }
    
    public var description: String {
        return self.defaultDescription(withProperties: ("productIdentifier", self.productIdentifier), ("expiryDate", self.expiryDate ?? "nil"), ("purchaseDate", self.purchaseDate ?? "nil"), ("originalPurchaseDate", self.originalPurchaseDate ?? "nil"), ("cancelationDate", self.cancelationDate ?? "nil"))
    }
}
