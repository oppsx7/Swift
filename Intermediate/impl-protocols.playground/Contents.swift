import UIKit

protocol Parser {
    
    associatedtype Input
    associatedtype Output
    
    func parse(input: Input) -> Output
    
}

extension Parser {
    func parse(input: String) -> [String] {
        return ["<html></html>", "<p></p>"]
    }
}

class XHTMLParser: Parser {
    func parse(input: Int) -> [Int] {
        return [1,2]
    }
}

class TextFileParser: Parser {
    func parse(input: String) -> String {
        return ""
    }
}

class HTMLParser: Parser {
    func parse(input: String) -> [String] {
        return []
    }
}

class JsonParser: Parser {
    
    typealias Input = String
    typealias Output = [String:String]
    
    func parse(input: Input) -> Output {
        return [:]
    }
}

func runParser<P: Parser>(parser: P, input: [P.Input]) where P.Input == JsonParser {
    input.forEach {
        _ = parser.parse(input: $0)
    }
}
