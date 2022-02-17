//
//  Constants.swift
//  MarvelApp
//
//  Created by crodrigueza on 16/2/22.
//

import Foundation

struct Constants {
    static let appName = "Marvel App"
    static let appIcon = "icnMarvel"

    struct NetworkManager {
        static let version = 1
        static let type = "public"
        static let timeStamp = Date().timeIntervalSince1970
        static let publicApiKey = "bdd7f1b10e8f1b342807f0d5a01f3e03"
        static let privateApiKey = ""   // TODO: Insert private api key

        struct URLs {
            static let base = "https://gateway.marvel.com/"
        }

        struct Endpoints {
            static let version = "v\(NetworkManager.version)/"
            static let type = "\(NetworkManager.type)/"
            static let timeStamp = "?ts=\(NetworkManager.timeStamp)"
            static let hash = "&hash="
            static let apiKey = "?api_key=\(Constants.NetworkManager.publicApiKey)"
            static let characters = "characters"
        }
    }

    struct CustomCells {
        static let superheroCellId = "SuperheroCustomCell"
    }
}
