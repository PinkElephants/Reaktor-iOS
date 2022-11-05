//
//  UserRequest.swift
//  Reaktor
//
//  Created by Kirill Ivonin on 05/11/2022.
//

import Foundation

struct UserRequest: RequestMaker & ResponseParser {
    typealias ResponseType = User
    typealias EndpointType = Endpoint

    var type: RequestType = .user

    func makeRequest() throws -> URLRequest {
        let userEndpoint = EndpointType.user(uuid: User.UserID)
        let url = try userEndpoint.url

        return URLRequest(url: url)
    }

    func parse(_ responseData: Data) throws -> ResponseType {
        try CustomDecoder().decode(ResponseType.self, from: responseData)
    }
}
