//
//  MBNetwork.swift
//  MovieBox
//
//  Created by EbubekirSezer on 28.08.2022.
//

import Foundation
import Alamofire

final class MBNetwork {
    
    static let shared = MBNetwork()
    
    public func request<T: Codable>(route: MBRouter, responseModel: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        do {
            let urlRequest = try route.asURLRequest()
            AF.request(urlRequest).validate().responseJSON { response in
                switch response.result {
                case .success(let result):
                    do {
                        // JSON
                        if let resultValue = result as? [String: Any] {
                            let jsonData = try JSONSerialization.data(withJSONObject: resultValue, options: .prettyPrinted)
                            let jsonResults = try JSONDecoder().decode(responseModel, from: jsonData)
                            completion(.success(jsonResults))
                        }
                        // Array of JSON
                        if let resultValue = result as? [[String: Any]] {
                            let jsonData = try JSONSerialization.data(withJSONObject: resultValue, options: .prettyPrinted)
                            let jsonResults = try JSONDecoder().decode(responseModel, from: jsonData)
                            completion(.success(jsonResults))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}
