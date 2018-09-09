import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NewsAPI {
    case topHeadings
    case articles(String)
    case sources(NewsSource.Category)
}

extension NewsAPI: TargetType {
    var baseURL: URL { return URL(string: "https://newsapi.org/v2")! }
    
    var path: String {
        switch self {
        case .topHeadings:
            return "/top-headlines"
        case .articles(let source):
            return "/everything?sources=\(source)"
        case .sources(let category):
            return "/sources?category=\(category.rawValue)"
        }
    }
    
    var method: HTTPMethod { return .get }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return ["X-Api-Key": Constants.NewsAPI.APIKey]
    }
    
}

let newsProvider = NetworkProvider<NewsAPI>()
