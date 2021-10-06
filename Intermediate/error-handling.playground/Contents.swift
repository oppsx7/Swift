import UIKit
import Foundation
import Security

struct Post: Decodable {
    let title: String
    let body: String
}

enum NetworkError: Error {
    case badURL
    case invalidData
    case decodingError
}

func getPosts(with url: URL, success: @escaping ([Post]) -> Void, failure: @escaping (NetworkError?) -> Void) {
    
    URLSession.shared.dataTask(with: url) { (data, _ ,error) in
        guard let data = data, error == nil else {
            failure(NetworkError.invalidData)
            return
        }
        
        let posts = try? JSONDecoder().decode([Post].self, from: data)
        if let posts = posts {
            success(posts)
        } else {
            failure(NetworkError.decodingError)
        }
    }
}


guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
    throw NetworkError.badURL
}

getPosts(with: url) { (posts) in
    
} failure: { (error) in
    
}

//MARK: DIFFERENT TYPE OF ERRORS

struct Account: Codable {
    let balance: Double
}

struct Transaction: Codable {
    let from: Account
    let to: Account
    let amountToLow: Double
}

enum AccountError: Error {
    case insufficientFunds
    case amountToLow
}

func transferFunds(url: URL, from: Account, to: Account, amount: Double, completion: @escaping (Result<String, Error>) -> Void) {
    
    guard amount > 0 else {
        completion( .failure(AccountError.amountToLow))
        return
    }
    
    guard from.balance > amount else {
        completion(.failure(AccountError.insufficientFunds))
        return
    }
    
    var request = URLRequest(url: url)
    let transaction = Transaction(from: from, to: to, amountToLow: amount)
    request.httpBody = try? JSONEncoder().encode(transaction)
    
    URLSession.shared.dataTask(with: request) { (data, _, error) in
        guard let data = data, error == nil else {
            completion(.failure(NetworkError.invalidData))
            return
        }
        
        print(data)
    }.resume()
    
}

guard let url = URL(string: "urllll") else {
    throw NetworkError.badURL
}

let fromAccount = Account(balance: 100)
let toAccount = Account(balance: 50)
let amount = 555.0

transferFunds(url: url, from: fromAccount, to: toAccount, amount: amount) { (result) in
    switch result {
    case .success(let statusCode):
        print(statusCode)
    case .failure(AccountError.amountToLow):
        print("Amount to low")
    case .failure(NetworkError.invalidData), .failure(NetworkError.decodingError):
        print("Generic Error Message")
    default:
        print("Generic Error Message")
    }
}
