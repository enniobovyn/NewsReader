import Foundation

struct ArticlesResponseObject: Decodable {
    
    let status: String
    let totalResults: Int
    let articles: [Article]
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case totalResults = "totalResults"
        case articles = "articles"
    }
    
}

struct Article: Decodable {
    
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    
    struct Source: Decodable {
        let id: String
        let name: String
    }
    
}
