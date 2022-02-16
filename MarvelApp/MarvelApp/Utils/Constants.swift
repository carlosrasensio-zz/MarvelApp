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
        static let privateApiKey = "abcc3c94cdfc3e6569c3c732d9c16565629dfcb3"   // TODO: NOT SAVE!

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

        func createMD5() -> String {
            let unhashedString = "\(NetworkManager.timeStamp)" +
                                NetworkManager.privateApiKey +
                                NetworkManager.publicApiKey

            return unhashedString.convertToMD5()
        }

        func getHash() -> String {
            return NetworkManager.Endpoints.hash + createMD5()
        }

        func getCharactersEndpoint() -> String {
            return NetworkManager.Endpoints.version +
                NetworkManager.Endpoints.type +
                NetworkManager.Endpoints.characters +
                NetworkManager.Endpoints.apiKey +
                getHash()
        }

        func getCharactersURL() -> URL {
            return URL(string: NetworkManager.URLs.base + getCharactersEndpoint())!
        }

        func getCharactersURLRequest() -> URLRequest {
            return URLRequest(url: getCharactersURL())
        }
    }

    struct CustomCells {
        static let superheroCellId = "SuperheroCustomCell"
    }

}
