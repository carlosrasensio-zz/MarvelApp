//
//  NetworkManager.swift
//  MarvelApp
//
//  Created by crodrigueza on 16/2/22.
//

import Foundation
import RxSwift

protocol NetworkManagerProtocol {
    func getSuperheroes() -> Observable<[Superhero]>
}

class NetworkManager: NetworkManagerProtocol {
    func getSuperheroes() -> Observable<[Superhero]>  {
        return Observable.create { observer -> Disposable in
            let unhashedEndpointString = "\(Constants.NetworkManager.timeStamp)" +
                        Constants.NetworkManager.privateApiKey +
                        Constants.NetworkManager.publicApiKey
            let hashString = Constants.NetworkManager.Endpoints.hash +                  unhashedEndpointString.convertToMD5()
            let endpointString = Constants.NetworkManager.Endpoints.version +
                                Constants.NetworkManager.Endpoints.type +
                                Constants.NetworkManager.Endpoints.characters +
                                Constants.NetworkManager.Endpoints.apiKey +
                                hashString
            let url = URL(string: Constants.NetworkManager.URLs.base  + endpointString)!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-type")
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let superheroes = try decoder.decode([Superhero].self, from: data)

                        observer.onNext(superheroes)
                    } catch let error {
                        print("\n[X] Error: \(error.localizedDescription)\n")
                    }
                } else if response.statusCode == 400 {
                    print("\n[X] Error: 401\n")
                }
                observer.onCompleted()
            }
            task.resume()

            return Disposables.create {
                session.finishTasksAndInvalidate()
            }
        }
    }
}
