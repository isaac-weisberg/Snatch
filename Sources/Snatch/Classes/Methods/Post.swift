import Foundation
import ResultKit

/**
    This extension adds capability to perform post requests.
*/
public extension Snatch {
    public class Post {
        internal let encoder = JSONBodyEncoding()

        public func generate<Parameters: Encodable>(_ url: URL, _ parameters: Parameters? = nil, _ headers: [String: String]? = nil) -> SnatchResult<URLRequest> {
            var request = URLRequest(url: url)

            request.httpMethod = "POST"

            let res = apply(parameters: parameters, to: &request)
            switch res {
            case .failure(let error):
                return .failure(error)
            default: break;
            }
            
            if let headers = headers {
                request.allHTTPHeaderFields = headers
            }

            return .success(request)
        }

        internal func apply<Parameters: Encodable>(parameters: Parameters?, to request: inout URLRequest) -> SnatchResult<Void> {
            if let parameters = parameters {
                return encoder.apply(parameters, to: &request)
            }
            return .success(())
        }
    }
}
