import Foundation

typealias ReqResCapsule = RequestMaker & ResponseParser

struct ReaktorListRequest: RequestMaker & ResponseParser {
    typealias ResponseType = [Graph]
    typealias EndpointType = Endpoint

    var type: RequestType = .graphs

    func makeRequest() throws -> URLRequest {
        let url = try EndpointType.graphs.url
        return URLRequest(url: url)
    }

    func parse(_ responseData: Data) throws -> ResponseType {
        try CustomDecoder().decode(ResponseType.self, from: responseData)
    }
}
