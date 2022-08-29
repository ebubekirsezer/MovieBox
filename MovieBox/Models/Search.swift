//
//  Search.swift
//  MovieBox
//
//  Created by EbubekirSezer on 28.08.2022.
//

import Foundation

class SearchResponse: Codable {
    var search: [Movie]?
    var totalResults: String?
    var response: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}
