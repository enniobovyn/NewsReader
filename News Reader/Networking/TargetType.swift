import Foundation

protocol TargetType {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var body: [String: Any] { get }
    var headers: [String: String] { get }
}
