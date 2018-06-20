import Foundation

/**
    This extension adds capability to perform get requests.
*/
public extension Snatch {
    public class Get {
        internal let encoder = URLQueryEncoding()
        
        public func generate(_ url: URL, _ parameters: URLQueryEncoding.Parameters? = nil, _ headers: [String: String]? = nil) throws -> URLRequest {
            let newUrl: URL
            if let parameters = parameters {
                newUrl = try encoder.swapQuery(of: url, with: parameters)
            } else {
                newUrl = url
            }
            
            var request = URLRequest(url: newUrl)
            
            request.allHTTPHeaderFields = headers
            
            return request
        }
    }
}
