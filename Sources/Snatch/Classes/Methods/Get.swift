import Foundation

/**
    This extension adds capability to perform get requests.
*/
public extension Snatch {
    public class Get {
        internal let encoder = URLQueryEncoding()
        
        public func generate(_ url: URL, _ parameters: URLQueryEncoding.Parameters? = nil, _ headers: [String: String]? = nil) -> SnatchResult<URLRequest> {
            let newUrl: URL
            if let parameters = parameters {
                let res = encoder.swapQuery(of: url, with: parameters)
                switch res {
                case .success(let url):
                    newUrl = url
                case .failure(let error):
                    return .failure(error)
                }
            } else {
                newUrl = url
            }
            
            var request = URLRequest(url: newUrl)
            
            request.allHTTPHeaderFields = headers
            
            return .success(request)
        }
    }
}
