//
//  RequestHandler.swift
//  MarvelApp
//
//  Created by crodrigueza on 17/2/22.
//

import Foundation

class RequestHandler {
    func getCharactersURL() -> URL {
        let baseURL = URL(string: Constants.NetworkManager.URLs.base)
        let timestamp = "\(Constants.NetworkManager.timeStamp)"
        let publicKey = Constants.NetworkManager.publicApiKey
        let privateKey = Constants.NetworkManager.privateApiKey
        let unhashedString = timestamp + privateKey + publicKey
        let hashToken = unhashedString.convertToMD5()
        let limit = "\(Constants.NetworkManager.limit)"
        let endpoint = Constants.NetworkManager.Endpoints.version + Constants.NetworkManager.Endpoints.type + Constants.NetworkManager.Endpoints.characters
        var components = URLComponents(url: baseURL!.appendingPathComponent(endpoint), resolvingAgainstBaseURL: true)
        let customQueryItems = [URLQueryItem]()
        let commonQueryItems = [
            URLQueryItem(name: "ts", value: timestamp),
            URLQueryItem(name: "hash", value: hashToken),
            URLQueryItem(name: "apikey", value: publicKey),
            URLQueryItem(name: "limit", value: limit)
        ]
        components?.queryItems = commonQueryItems + customQueryItems
        guard let url = components?.url else {
            return URL(string: "https://gateway.marvel.com/v1/public/characters?ts=\(timestamp)&hash=\(hashToken)&apikey=\(publicKey)")!
        }

        return url
    }
}
