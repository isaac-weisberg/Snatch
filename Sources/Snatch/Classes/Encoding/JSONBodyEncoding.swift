import Foundation
import ResultKit

public class JSONBodyEncoding {
    let encoder = JSONEncoder()

    public func encode<Parameters: Encodable>(_ parameters: Parameters) -> SnatchResult<Data> {
        do {
            return .success(try encoder.encode(parameters))
        } catch {
            return .failure(SnatchError.encoding(error))
        }
    }

    public func apply<Parameters: Encodable>(_ parameters: Parameters, to request: inout URLRequest) -> SnatchResult<Void> {
        let res = encode(parameters)
        switch res {
        case .success(let data):
            request.httpBody = data
            return .success(())
        case .failure(let error):
            return .failure(error)
        }
    }
}
