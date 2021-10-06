import UIKit

struct Category {
    let name: String
}

enum FakeError: Error { }

protocol Service {
    associatedtype Value
    associatedtype Err: Error
    func load(completion: (Result<Value, Err>) -> Void)
}

class CategoryService: Service {
    
    func load(completion: (Result<[Category], FakeError>) -> Void) {
        completion(.success([Category(name: "Fiction"), Category(name: "Horror"), Category(name: "Kids")]))
    }
}

CategoryService().load(completion: { (result) in
    switch result {
    case .success(let categories):
        print(categories)
    }
})
