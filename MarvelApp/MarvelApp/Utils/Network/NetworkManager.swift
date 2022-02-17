//
//  NetworkManager.swift
//  MarvelApp
//
//  Created by crodrigueza on 16/2/22.
//

import Foundation
import RxSwift

protocol NetworkManagerProtocol {
    func getCharacters() -> Observable<[Character]>
}

class NetworkManager: NetworkManagerProtocol {
    func getCharacters() -> Observable<[Character]>  {
        return Observable.create { observer -> Disposable in
            let requestHandler = RequestHandler()
            let url = requestHandler.getCharactersURL()
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(CharacterDataWrapper.self, from: data)
                        observer.onNext(response.data.results)
                    } catch let error {
                        print("\n[X] Error: \(error.localizedDescription)\n")
                    }
                } else {
                    print("\n[X] Error: \(response.statusCode)\n")
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
