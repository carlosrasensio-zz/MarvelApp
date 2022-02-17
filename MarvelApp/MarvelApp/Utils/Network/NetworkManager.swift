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
            let requestHandler = RequestHandler()
            var request = requestHandler.getCharactersURLRequest()
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
