//
//  CharacterListViewModel.swift
//  MarvelApp
//
//  Created by crodrigueza on 16/2/22.
//

import Foundation
import RxSwift

protocol CharacterListViewModelProtocol {
    var view: CharacterListViewControllerProtocol? { get set }
    var router: CharacterListRouterProtocol? { get set }
    func bind(view: CharacterListViewControllerProtocol, router: CharacterListRouterProtocol)
    func getCharacters() -> Observable<[Character]>
    func createCharacterDetailView(_ character: Character)
}

class CharacterListViewModel: CharacterListViewModelProtocol {
    // MARK: - Variables
    var view: CharacterListViewControllerProtocol?
    var router: CharacterListRouterProtocol?
    private var networkManager = NetworkManager()

    // MARK: - Connecting view and router
    func bind(view: CharacterListViewControllerProtocol, router: CharacterListRouterProtocol) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view as? UIViewController)
    }

    // MARK: - Get data from service
    func getCharacters() -> Observable<[Character]> {
        return networkManager.getCharacters()
    }

    // MARK: - Navigat
    func createCharacterDetailView(_ character: Character) {
        router?.navigateToCharacterDetail(character)
    }
}
