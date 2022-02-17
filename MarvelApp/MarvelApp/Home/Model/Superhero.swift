//
//  Superhero.swift
//  MarvelApp
//
//  Created by crodrigueza on 16/2/22.
//

import Foundation

struct Response: Codable, Equatable {
    let data: Data
}

struct Data: Codable, Equatable {
    let results: [Superhero]
}

struct Superhero: Codable, Equatable {
    let name: String
    let description: String
    let thumbnail: Thumbnail

    static func == (lhs: Superhero, rhs: Superhero) -> Bool {
        return lhs.name == rhs.name &&
            lhs.description == rhs.description &&
            lhs.thumbnail == rhs.thumbnail
    }
}

struct Thumbnail: Codable, Equatable {
    let path: String
    let imageExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
}
