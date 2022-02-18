//
//  CharacterDataContainer.swift
//  MarvelApp
//
//  Created by crodrigueza on 17/2/22.
//

import Foundation

struct CharacterDataContainer: Codable, Equatable {
    let total: Int
    let count: Int
    let results: [Character]

    static func == (lhs: CharacterDataContainer, rhs: CharacterDataContainer) -> Bool {
        return lhs.results == rhs.results
    }
}
