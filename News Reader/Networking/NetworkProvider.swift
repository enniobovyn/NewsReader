import Foundation

class NetworkProvider<Target: TargetType> {
    
    func request(_ target: Target, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        if let urlString = url(target).removingPercentEncoding {
            
            guard let url = URL(string: urlString) else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = target.method.rawValue
            request.allHTTPHeaderFields = target.headers
            
            let session = URLSession.shared
            session.dataTask(with: request, completionHandler: completion).resume()
            
        }
    }
    
    private func url(_ target: Target) -> String {
        return target.baseURL.appendingPathComponent(target.path).absoluteString
    }
    
}
