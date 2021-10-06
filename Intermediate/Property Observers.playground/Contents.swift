import UIKit

struct Website {
    
    var url: String {
        
        willSet {
            
        }
        
        didSet {
            url = url.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? url
        }
    }
    
    init(url: String ) {
        defer { self.url = url }
        
        self.url = url
    }
}

var website = Website(url: "www.movies.com/?search=Lord of the Rings")
//website.url = "www.movies.com/?search = Lod of the Rings"
print(website)


