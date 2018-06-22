import Foundation

/**
    Exists to collate results of an HTTP request into a single entity.
*/
final public class Result {
    public class NoBodyError: Error {
        
    }
    
    /**
        Raw body of the response.
    */
    public let data: Data?

    /**
        URLSessions' response object.
    */
    public let response: HTTPURLResponse

    public init(from response: HTTPURLResponse, _ data: Data? = nil) {
        self.response = response
        self.data = data
    }
    
    public func json<Target: Decodable>(_ type: Target.Type) throws -> Target {
        guard let data = data else {
            throw NoBodyError()
        }
        let decoder = JSONDecoder()
        
        let result: Target
        do {
            result = try decoder.decode(type, from: data)
        } catch {
            throw SnatchError.encoding(error)
        }
        
        return result
    }
}
