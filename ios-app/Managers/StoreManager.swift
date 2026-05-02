import Foundation
import StoreKit

/// StoreManager handles Apple StoreKit 2 integrations for the Black Membership.
/// It fetches products, processes purchases, and verifies active subscriptions.
@MainActor
class StoreManager: ObservableObject {
    @Published var isBlackMember: Bool = false
    @Published var products: [Product] = []
    @Published var purchaseError: String? = nil
    
    // Product IDs defined in App Store Connect
    private let membershipProductID = "com.mentalconcierge.bodrum.blackmembership.yearly"
    
    init() {
        Task {
            await requestProducts()
            await updateCustomerProductStatus()
        }
    }
    
    /// Fetches the subscription products from App Store Connect
    func requestProducts() async {
        do {
            let storeProducts = try await Product.products(for: [membershipProductID])
            self.products = storeProducts
        } catch {
            print("Failed to fetch products: \(error)")
        }
    }
    
    /// Initiates the purchase flow for the selected product
    func purchase(_ product: Product) async {
        do {
            let result = try await product.purchase()
            
            switch result {
            case .success(let verification):
                // Verify the transaction is signed by Apple
                let transaction = try checkVerified(verification)
                
                // Unlock the Black Membership UI
                await transaction.finish()
                await updateCustomerProductStatus()
                HapticManager.shared.celebrate()
                
            case .userCancelled:
                self.purchaseError = "Purchase cancelled."
            case .pending:
                self.purchaseError = "Purchase is pending approval."
            @unknown default:
                self.purchaseError = "An unknown error occurred."
            }
        } catch {
            self.purchaseError = "Failed to purchase: \(error.localizedDescription)"
        }
    }
    
    /// Checks the user's active entitlements to see if they are already a member
    func updateCustomerProductStatus() async {
        var hasActiveMembership = false
        
        // Iterate through all of the user's purchased products.
        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try checkVerified(result)
                
                // If it's the Black Membership and hasn't been revoked/expired
                if transaction.productID == membershipProductID {
                    hasActiveMembership = true
                }
            } catch {
                print("Transaction failed verification.")
            }
        }
        
        self.isBlackMember = hasActiveMembership
    }
    
    /// Verifies the StoreKit receipt cryptographically
    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let safe):
            return safe
        }
    }
}

enum StoreError: Error {
    case failedVerification
}
