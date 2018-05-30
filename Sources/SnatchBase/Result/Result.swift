import Foundation

/**
    Exists to collate results of an HTTP request into a single entity.
*/
final public class Result {
    public class NoBodyError: Error {
        var localizedDescription: String = "The response body is empty."
    }
    
    /**
        Raw body of the response.
    */
    public let data: Data?

    /**
        URLSessions' response object.
    */
    public let response: HTTPURLResponse

    init(from response: HTTPURLResponse, _ data: Data? = nil) {
        self.response = response
        self.data = data
    }
}
