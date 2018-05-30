import Foundation

/**
    This extension adds capability to perform post requests.
*/
public extension Snatch {
    public class Post {
        public weak var father: Snatch?

        public func generateRequest(outOf url: URL, _ headers: [String: String]? = nil) -> URLRequest {
            var request = URLRequest(url: url)

            request.httpMethod = "POST"

            if let headers = headers {
                request.allHTTPHeaderFields = headers
            }

            return request
        }

        public func apply<Parameters: Encodable>(parameters: Parameters?, to request: inout URLRequest) throws {
            if let parameters = parameters {
                let encoder = JSONBodyEncoding()

                try encoder.apply(parameters, to: &request)
            }
        }
    }
}
