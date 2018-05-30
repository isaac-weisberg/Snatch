import Foundation

public class URLQueryEncoding {
    public typealias Parameters = [AnyHashable: Any]
    
    /**
        Encodes a dictionary of parameters into a URLEncoded query. Expects all members to be escaped.

        - parameter dict: dictionary of parameters. Both keys and values of the dictionary must be representable as strings, otherwise - undefined behavior.

        - returns: string, a URLEncoded query.
    */
    public func encode(_ dict: Parameters) -> String {
        return dict.map { "\($0)=\($1)" }.joined(separator: "&")
    }

    /**
        Overrides the query of a url with the contents of query parameter.

        - parameter url: the source url.
        - parameter query: the query that is to be put into the url.

        - returns: a new url with a new query.
    */
    public func swapQuery(of url: URL, with query: String) throws -> URL {
        guard let components = url.components else {
            throw SnatchError.spooks
        }

        components.query = query

        guard let newURL = components.url else {
            throw SnatchError.spooks
        }

        return newURL
    }

    /**
        Overrides the query of a url with the parameters dictionary encoded in URLEncoding query.

        - parameter url: the source url.
        - parameter parameters: dictionary of parameters.

        - returns: a new url with a new query.
    */
    public func swapQuery(of url: URL, with parameters: Parameters) throws -> URL {
        let query = encode(parameters)
        return try swapQuery(of: url, with: query)
    }
}
