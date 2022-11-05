import Foundation

typealias ReqResCapsule = RequestMaker & ResponseParser

/// A request for a list of Reaktor
struct ReaktorListRequest: ReqResCapsule {
    typealias ResponseType = [Graph]
    typealias EndpointType = Endpoint

    func makeRequest() throws -> URLRequest {
        let url = try EndpointType.graphs.url
        return URLRequest(url: url)
    }

    func parse(_ responseData: Data) throws -> ResponseType {
        try CustomDecoder().decode(ResponseType.self, from: responseData)
    }
}
