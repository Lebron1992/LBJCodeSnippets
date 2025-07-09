import Foundation
import StoreKit

public typealias ProductsRequestCompletionHandler = (
  _ products: [SKProduct]?,
  _ error: Error?
) -> Void

public typealias ProductPurchaseCompletionHandler = (
  _ purchased: Bool,
  _ transaction: SKPaymentTransaction,
  _ error: Error?
) -> Void

open class IAPStore: NSObject {

  private var productsRequest: SKProductsRequest?
  private var productsRequestCompletionHandler: ProductsRequestCompletionHandler?
  private var productPurchaseCompletionHandler: ProductPurchaseCompletionHandler?

  public override init() {
    super.init()
    SKPaymentQueue.default().add(self)
  }
}

// MARK: - StoreKit API
extension IAPStore {

  open func requestProducts(identifiers: Set<String>, completionHandler: @escaping ProductsRequestCompletionHandler) {
    productsRequest?.cancel()
    productsRequestCompletionHandler = completionHandler

    productsRequest = SKProductsRequest(productIdentifiers: identifiers)
    productsRequest!.delegate = self
    productsRequest!.start()
  }

  open func buyProduct(_ product: SKProduct) {
    print("Buying \(product.productIdentifier)...")
    let payment = SKMutablePayment(product: product)
    SKPaymentQueue.default().add(payment)
  }

  open func completeTransaction(_ completionHandler: @escaping ProductPurchaseCompletionHandler) {
    productPurchaseCompletionHandler = completionHandler
  }

  open func finishTransaction(_ transaction: SKPaymentTransaction) {
    SKPaymentQueue.default().finishTransaction(transaction)
  }
}

// MARK: - SKProductsRequestDelegate
extension IAPStore: SKProductsRequestDelegate {

  public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
    let products = response.products
    productsRequestCompletionHandler?(products, nil)
    clearRequestAndHandler()

    for p in products {
      print("Found product: \(p.productIdentifier) \(p.localizedTitle) \(p.price.floatValue)")
    }
    for id in response.invalidProductIdentifiers {
      print("invalidProductIdentifier: \(id)")
    }
  }

  public func request(_ request: SKRequest, didFailWithError error: Error) {
    print("Failed to load list of products: \(error)")
    productsRequestCompletionHandler?(nil, error)
    clearRequestAndHandler()
  }

  private func clearRequestAndHandler() {
    productsRequest = nil
    productsRequestCompletionHandler = nil
  }
}

// MARK: - SKPaymentTransactionObserver
extension IAPStore: SKPaymentTransactionObserver {
  public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
    for transaction in transactions {
      switch transaction.transactionState {
      case .purchased, .restored:
        purchased(transaction: transaction)
      case .failed:
        fail(transaction: transaction)
      default: break
      }
    }
  }

  private func purchased(transaction: SKPaymentTransaction) {
    print("purchased...")
    productPurchaseCompletionHandler?(true, transaction, nil)
  }

  private func fail(transaction: SKPaymentTransaction) {
    print("fail...")
    if let transactionError = transaction.error as NSError?,
       let localizedDescription = transaction.error?.localizedDescription,
       transactionError.code != SKError.paymentCancelled.rawValue {
      print("Transaction Error: \(localizedDescription)")
    }

    productPurchaseCompletionHandler?(false, transaction, transaction.error)
    SKPaymentQueue.default().finishTransaction(transaction)
  }
}

// MARK: - Getters
extension IAPStore {
  public var receipt: String? {
    guard let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
          FileManager.default.fileExists(atPath: appStoreReceiptURL.path) else {
      return nil
    }
    do {
      let receiptData = try Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
      let receiptString = receiptData.base64EncodedString(options: [])
      return receiptString
    } catch {
      print("Couldn't read receipt data with error: " + error.localizedDescription)
      return nil
    }
  }
}
