# MerchantKit (working but work-in-progress)
A modern In-App Purchases management framework for iOS developers.

`MerchantKit` dramatically simplifies the work indie developers have to do in order to add premium monetizable components to their applications. Track purchased products, offer auto-renewing subscriptions, restore transactions, and much more.

Designed for apps that have a finite set of purchasable products, `MerchantKit` is a great way to add an unlockable 'pro tier' to an application, as a one-time purchase or ongoing subscription.

## Example Snippets

Find out if a product has been purchased:

```swift
let product = merchant.product(withIdentifier: "iap.productidentifier")
print("isPurchased", merchant.state(for: product).isPurchased)
```

Buy a product:

```swift
let task = merchant.commitPurchaseTask(for: purchase)
task.onCompletion = { result in 
    switch result {
        case .succeeded(_):
            print("purchase completed")
        case .failed(let error):
            print("\(error)")
    }
}

task.start()
```

Get notified when a subscription expires:

```swift
public func merchant(_ merchant: Merchant, didChangeStatesFor products: Set<Product>) {
    if let subscriptionProduct = products.first(where: { $0.identifier == "subscription.protier" }) {
        let state = merchant.state(for: subscriptionProduct)
        
        switch state {
            case .isSubscribed(let expiryDate):
                print("subscribed, expires \(expiryDate)")
            default:
                print("does not have active subscription")
        }
    }
}
```

## Project Goals

- Straightforward, concise, API to support non-consumable, consumable and subscription In-App Purchases.
- Simplify the development of In-App Purchase interfaces in apps, including localized formatters to dynamically create strings like "£2.99 per month" or "Seven Day Free Trial".
- No external dependencies beyond what Apple ships with iOS. The project links Foundation and StoreKit. 
- Prioritise developer convenience and accessibility over security. `MerchantKit` users accept that some level of piracy is inevitable and not worth chasing.
- Permissive open source license.
- Compatibility with latest Swift version using idiomatic language constructs.

The codebase is in flux right now and the project does not guarantee API stability. `MerchantKit` is useful, it works, and will probably save you time. That being said, `MerchantKit` is by no means finished and there are major components that are in the project's scope but completely unimplemented (predominantly, consumable products are not supported). The test suite is currently bare.

## Getting Started

1. Compile the `MerchantKit` framework and embed it in your application. The easiest way to get up and running right now is to use Cocoapods; add `MerchantKit` to your app's Podfile and build. You can also just download the source code from Github and install it manually, although you'll have to upgrade to the latest releases manually.

2. In your app delegate, import `MerchantKit` create a `Merchant` instance in `application(_:, didFinishLaunchingWithOptions:)`. Supply a storage object (recommended: `KeychainPurchaseStorage`) and a delegate.
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    ...
    
    self.merchant = Merchant(storage: KeychainPurchaseStorage(serviceName: "AppName"), delegate: self)
    
    ...
}
```

3. Implement the two required methods in `MerchantDelegate` to validate receipt data and receive notifications when the `PurchasedState` changes for registered products.
```swift
func merchant(_ merchant: Merchant, didChangeStatesFor products: Set<Product>) {
    for product in products {
        print("updated \(product)")
    }
 }
    
func merchant(_ merchant: Merchant, validate request: ReceiptValidationRequest, completion: @escaping (Result<Receipt>) -> Void) {
    let validator = LocalReceiptValidator(request: request)
    validator.onCompletion = { result in
        completion(result)
    }
        
    validator.start()
}
```
4. Register products as soon as possible (typically within `application(_:, didFinishLaunchingWithOptions:)`). You may want to load these products from a resource file. The included `LocalConfiguration` object provides a mechanism for this.
```swift
let config = try! MerchantKit.LocalConfiguration(fromResourceNamed: "MerchantConfig", extension: "plist")
self.merchant.register(config.products)

```
5. Call `setup()` on the merchant instance before escaping the `application(_:, didFinishLaunchingWithOptions:)` method. This tells the merchant to start observing the payment queue.
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    ...
    
    self.merchant = Merchant(storage: KeychainPurchaseStorage(serviceName: "AppName"), delegate: self)    
    self.merchant.register(...)
    self.merchant.setup()
    
    ...
}
```
6. Profit! Or something.

## Straightforward Product Interfaces
The tasks vended by a `Merchant` give developers access to the core operations to fetch and purchase products with interfaces that reflect Swift idioms better than the current `StoreKit` offerings. `PurchaseInterfaceController` is a higher-level API and may eliminate the need to create tasks manually altogether.

The `PurchaseInterfaceController` class encompasses common behaviours needed to present In-App Purchase for sale. However, it remains abstract enough to support many use cases. 

Developers simply provide the list of products to display and tells the controller to fetch data. The `delegate` notifies the app when to update its custom UI. It handles loading data, intermittent network connectivity and in-flight changes to the availability and state of products.  

## Formatters 
`MerchantKit` includes several formatters to help developers display the cost of In-App Purchases to users. 

`PriceFormatter` is the simplest. Just give it a `Price` and it returns formatted strings like '£3.99' or '$5.99' in accordance with the store's regional locale. You can specify a custom string if the price is free.
`SubscriptionPriceFormatter` takes a `Price` and a `SubscriptionDuration`. Relevant `Purchase` objects exposes these values so you can simply pass them along the formatter. It generates strings like '$0.99 per month', '£9.99 every 2 weeks' and '$4.99 for 1 month' depending on the period and whether the subscription will automatically renew. 

In addition to the renewal duration, subscriptions can include free trials and other introductory offers. You can use a `SubscriptionPeriodFormatter` to format a text label in your application. If you change the free trial offer in iTunes Connect, the label will dynamically update to reflect the changed terms without requiring a new App Store binary. For example:
```swift
func subscriptionDetailsForDisplay() -> String? {
    guard let terms = purchase.subscriptionTerms else { return nil }
    
    let formatter = SubscriptionPeriodFormatter()
    
    switch terms {
        case .freeTrial(let price, let period): return "\(formatter.string(from: period)) Free Trial" /// something like '7 Day Free Trial'
        default: ...
    }
}
```

`PriceFormatter` works in every locale supported by the App Store. `SubscriptionPriceFormatter` and `SubscriptionPeriodFormatter` are currently offered in a small subset of languages. Voluntary translations are welcomed.

## To Be Completed (in no particular order)

- Add tests to the bare test suite. Components can be tested separately, including the validators and `PurchaseStorage` types.
- Implement consumable purchases. This will likely involve a special delegate callback to tell the application to update its quantities.
- Increase the number of localizations for `SubscriptionPriceFormatter` and `SubscriptionPeriodFormatter`.
- Extended documentation with example usage projects.
- Document how to use `PurchaseInterfaceController`.
- Extend failure cases with richer error feedback when things go wrong. 
- Support downloadable content In-App Purchases.
- Probably a lot more stuff I haven't thought of yet.

## Credits

Developed and managed by [Benjamin Mayo](http://benjaminmayo.co.uk), [@bzamayo](http://twitter.com/bzamayo) on Twitter.
