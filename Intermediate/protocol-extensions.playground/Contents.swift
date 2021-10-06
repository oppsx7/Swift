import UIKit

protocol Account {
    var balance: Double { get set }
    
    mutating func deposit(_ amount: Double)
    mutating func withdraw(_ amount: Double)
    func transfer(from: Account, to: Account, amount: Double)
    func calculateInterestEarned() -> Double
}

extension Account {
    mutating func deposit(_ amount: Double) {
        balance += amount
    }
    
    mutating func withdraw(_ amount: Double) {
        balance -= amount
    }
    
    func calculateInterestEarned() -> Double {
        return (balance * (0.1/100))
    }
}

struct VerificationRequest {
    let accounts: [Account]
}

struct VerificationResponse {
    let verified: Bool
}

protocol Verification {
    func performVerification(_ request: VerificationRequest, completion: (VerificationResponse) -> Void)
}

extension Verification {
    func performVerification(_ request: VerificationRequest, completion: (VerificationResponse) -> Void) {
        // perform verification
    }
}

struct CheckingAccount: Account, Verification {
    var balance: Double
    
    func transfer(from: Account, to: Account, amount: Double) {
        performVerification(VerificationRequest(accounts: [from, to]), completion: { (response) in })
    }
    
}

struct MoneyMarketAccount: Account {
    var balance: Double
    
    func transfer(from: Account, to: Account, amount: Double) {
        
    }
}
