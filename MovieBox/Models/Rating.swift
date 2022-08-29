//
//  Rating.swift
//  MovieBox
//
//  Created by EbubekirSezer on 28.08.2022.
//

import Foundation

final class Rate: Codable {
    var source: String?
    var value: String?
    
    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}
