import Foundation

public class Snatch {
    /**
        The underlying URLSession object.
    */
    public let session: URLSession

    /**
        A reference to a Get module.
    */
    public let get = Get()

    /**
        A reference to a Post module.
    */
    public let post = Post()

    /**
        A handler type used for dataTask completion on URLSession.
    */
    public typealias DataTaskCallback = (Data?, URLResponse?, Error?) -> Void
    public typealias SnatchTaskCallback = (Result?, SnatchError?) -> Void

    public init(with sessionConfig: URLSessionConfiguration = URLSessionConfiguration.default) {
        session = URLSession(configuration: sessionConfig)
        // Give a reference to a Snatch instance to all the extensions.
        get.father = self
        post.father = self
    }
    
    /**
        Creates a data task out of an arbitrary request object and DataTaskCallback

        - parameter request: URLRequest object
        - parameter handler: completion handler for the data task

        - returns: URLSessionDataTask, the data task that needs to be resumed in order to be started.
    */
    public func task(with request: URLRequest, _ handler: @escaping SnatchTaskCallback) -> URLSessionDataTask {
        return session.dataTask(with: request, completionHandler: adaptedHandler(handler))
    }
    
    internal func adaptedHandler(_ callback: @escaping SnatchTaskCallback) -> DataTaskCallback {
        return { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                callback(nil, .spooks)
                return
            }
            var snatchError: SnatchError?
            if let error = error {
                snatchError = .connection(error)
            }
            callback(Result(from: response, data), snatchError)
        }
    }
}
