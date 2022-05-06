//
//  iAPManager.swift
//  Birdy
//
//  Created by Леонід Шевченко on 05.05.2022.
//

import Foundation
import StoreKit

final class iAPManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    static let shared = iAPManager()

    public var paymentStatus: Int {
        return UserDefaults.standard.integer(forKey: "paymentStatus")
    }
    
    var products = [SKProduct]()
    
    private var completion: (() -> Void)?
    
    public func fetchProduct() {
        let request = SKProductsRequest(productIdentifiers: ["finalLevel"])
        request.delegate = self
        request.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("Products return: \(response.products.count)")
        
        self.products = response.products
    }
    
    public func purchase(completion: @escaping(() -> Void)) {
        guard SKPaymentQueue.canMakePayments() else {
            return
        }
        
        guard let storeKitProduct = self.products.first else {
            return
        }
        
        self.completion = completion
        
        let paymentRequest = SKPayment(product: storeKitProduct)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(paymentRequest)
    }
    
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach({
            switch $0.transactionState {
            case .purchasing:
                break
            case .purchased:
                SKPaymentQueue.default().finishTransaction($0)
                SKPaymentQueue.default().remove(self)
                
                // Upload new payment status after purchasing
                let currentCount = paymentStatus
                let newCount = currentCount + 1
                UserDefaults.standard.setValue(newCount, forKey: "paymentStatus")

                completion?()
            case .failed:
                break
            case .restored:
                break
            case .deferred:
                break
            @unknown default:
                break
            }
        })
    }
}
