//
//  Superhero.swift
//  MarvelApp
//
//  Created by crodrigueza on 16/2/22.
//

import Foundation

struct Superhero: Codable, Equatable {
    let name: String
    let description: String
    let thumbnail: Thumbnail

    struct Thumbnail {
        let path: String
        let imageExtension: String

        enum CodingKeys: String, CodingKey {
            case path
            case imageExtension = "extension"
        }
    }
}
