//
//  MBRouter.swift
//  MovieBox
//
//  Created by EbubekirSezer on 28.08.2022.
//

import Foundation
import Alamofire

enum MBRouter: URLRequestConvertible {
    case search(by: String)
    case detail(by: String)

    var method: HTTPMethod {
        switch self {
        case .search, .detail:
            return .get
        }
    }
    
    var params: [String: String] {
        switch self {
        case .search(let movieName):
            return [
                "s": movieName,
                "apikey": Constants.API_TOKEN
            ]
        case .detail(let id):
            return [
                "i": id,
                "apikey": Constants.API_TOKEN
            ]
        }
    }
    
    var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = Constants.HOST
        
        switch self {
        case .search, .detail:
            urlComponents.setQueryItems(with: params)
        }
        return urlComponents
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = urlComponents.url else { throw NSError() }
        
        print(url)
        // URL Params
        var urlRequest = URLRequest(url: url)
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
    
}


extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
