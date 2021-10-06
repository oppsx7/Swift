import UIKit
import Foundation

protocol CartProtocol {
    func computeTotal() -> Double
}

struct CartItem {
    let name: String
    let price : Double
}

struct Cart: CartProtocol {
    let items: [CartItem]
    
    func computeTotal() -> Double {
        return items.reduce(0) { (value, item) in
            return value + item.price
        }
    }
}

extension Array: CartProtocol where Element: CartProtocol {
    
    func computeTotal() -> Double {
        self.reduce(0) { (value, cart) in
            return value + cart.computeTotal()
        }
    }
}


let stores = [
    [Cart(items: [CartItem(name: "Milk", price: 4.5), CartItem(name: "Eggs", price: 2.5)]),
     Cart(items: [CartItem(name: "Fish", price: 12)])],
    [Cart(items: [CartItem(name: "Airpods", price: 164.5), CartItem(name: "iMac", price: 2302.50)]),
     Cart(items: [CartItem(name: "iPhone 12", price: 1200)])]
    ]
print(stores.computeTotal())
