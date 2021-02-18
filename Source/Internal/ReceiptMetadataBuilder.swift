import Foundation

internal struct ReceiptMetadataBuilder {
    var originalApplicationVersion: String = ""
    var bundleIdentifier: String = ""
    var creationDate: Date?
    var purchaseDate: Date?
    var originalPurchaseDate: Date?
    var cancellationDate: Date?
    
    init() {
        
    }
    
    func build() -> ReceiptMetadata {
        return ReceiptMetadata(originalApplicationVersion: self.originalApplicationVersion, bundleIdentifier: self.bundleIdentifier, creationDate: self.creationDate, purchaseDate: self.purchaseDate, originalPurchaseDate: self.originalPurchaseDate, cancelationDate: self.cancellationDate)
    }
}
