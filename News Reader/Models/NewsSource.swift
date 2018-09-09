import Foundation

struct SourcesResponseObject: Decodable {
    
    let status: String
    let sources: [NewsSource]
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case sources = "sources"
    }
    
}

struct NewsSource: Decodable {
    
    let id: String
    let name: String
    let description: String
    let url: String
    let category: Category
    let language: String
    let country: String

    enum Category: String, Decodable {
        case business = "business"
        case entertainment = "entertainment"
        case general = "general"
        case health = "health"
        case science = "science"
        case sports = "sports"
        case technology = "technology"
        case all = ""
    }
    
}
