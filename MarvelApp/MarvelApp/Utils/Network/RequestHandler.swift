//
//  RequestHandler.swift
//  MarvelApp
//
//  Created by crodrigueza on 17/2/22.
//

import Foundation

class RequestHandler {
    func getCharactersURLRequest() -> URLRequest {
        let unhashedEndpointString = "\(Constants.NetworkManager.timeStamp)" +
                    Constants.NetworkManager.privateApiKey +
                    Constants.NetworkManager.publicApiKey
        let hashString = Constants.NetworkManager.Endpoints.hash +                  unhashedEndpointString.convertToMD5()
        let endpointString = Constants.NetworkManager.Endpoints.version +
                            Constants.NetworkManager.Endpoints.type +
                            Constants.NetworkManager.Endpoints.characters +
                            Constants.NetworkManager.Endpoints.timeStamp +
                            Constants.NetworkManager.Endpoints.apiKey +
                            hashString
        let url = URL(string: Constants.NetworkManager.URLs.base  + endpointString)!
        let request = URLRequest(url: url)

        return request
    }
}
