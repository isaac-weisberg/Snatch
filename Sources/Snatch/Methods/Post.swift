import Foundation

/**
    This extension adds capability to perform post requests.
*/
public extension Snatch {
    public class Post {
        public weak var father: Snatch!
        
        internal let encoder = JSONBodyEncoding()

        public func generate<Parameters: Encodable>(_ url: URL, _ parameters: Parameters? = nil, _ headers: [String: String]? = nil) throws -> URLRequest {
            var request = URLRequest(url: url)

            request.httpMethod = "POST"

            try apply(parameters: parameters, to: &request)
            
            if let headers = headers {
                request.allHTTPHeaderFields = headers
            }

            return request
        }

        internal func apply<Parameters: Encodable>(parameters: Parameters?, to request: inout URLRequest) throws {
            if let parameters = parameters {
                try encoder.apply(parameters, to: &request)
            }
        }
    }
}
