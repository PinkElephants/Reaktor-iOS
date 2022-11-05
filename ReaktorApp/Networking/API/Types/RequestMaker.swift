import Foundation

/// A protocol to encapsulate the actions of making a request out of a specific `EndpointType`
protocol RequestMaker {
    associatedtype EndpointType
    func makeRequest() throws -> URLRequest
    var type: RequestType { get }
}

enum RequestType {
    case user
    case health
    case graphs
}
