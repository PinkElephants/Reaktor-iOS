import Foundation

/// A protocol to encapsulate the actions of decoding anr returning a response out of a specific `ResponseType`
protocol ResponseParser<ResponseType> where ResponseType: Decodable {
    associatedtype ResponseType
    
    func parse(_ responseData: Data) throws -> ResponseType
}
