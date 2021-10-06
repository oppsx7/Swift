import UIKit


enum NetworkError: Error {
    case badURL
}

struct Post: Codable {
    let title: String
}

enum Callback<T: Codable, K: Error> {
    case success(T)
    case failure(K)
}

func getPosts(completion: (Callback<[Post], NetworkError>) -> Void) {
    
    //get all posts
    let posts = [Post(title: "Hello World"), Post(title: "INtroduction to swift")]
    completion(.success(posts))
}

getPosts { (result) in
    switch result {
    case .success(let posts):
        print(posts)
    case .failure(let error):
        print(error)
    }
}
