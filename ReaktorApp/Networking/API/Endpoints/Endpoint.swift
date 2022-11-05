import Foundation

/// The Endpoint contains the base URL and structure to build an URL
struct Endpoint {
    let baseURL = URL(string: "https://reactor-api-ne3ne.ondigitalocean.app")!

    private let path: String
    private let queryItems: [URLQueryItem]

    init(path: String, queryItems: [URLQueryItem] = []) {
        self.path = path
        self.queryItems = queryItems
    }
}

extension Endpoint {
    var url: URL {
        get throws {
            var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!

            components.path = path
            components.queryItems = queryItems

            guard let url = components.url else {
                throw URLError(.badURL)
            }

            return url
        }
    }
}

extension Endpoint {
    static var graphs: Endpoint {
        Endpoint(path: "/graphs")
    }

    static func user(uuid: String) -> Endpoint {
        Endpoint(path: "/user/\(uuid)")
    }
}
