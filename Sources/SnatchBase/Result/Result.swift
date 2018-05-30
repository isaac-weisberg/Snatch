import Foundation

/**
    Exists to collate results of an HTTP request into a single entity.
*/
final public class Result {
    public class NoBodyError: Error {
        public static var new: NoBodyError {
            return NoBodyError()
        }
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
}
