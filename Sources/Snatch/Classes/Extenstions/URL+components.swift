import Foundation

public extension URL {
    var components: NSURLComponents? {
        return NSURLComponents(url: self, resolvingAgainstBaseURL: false)
    }
}
