//
//  FavoritesViewModel.swift
//  MarvelApp
//
//  Created by crodrigueza on 22/2/22.
//

import Foundation

protocol FavoritesViewModelProtocol {
    var view: FavoritesViewController? { get }
    var router: FavoritesRouter? { get }
    func bind(view: FavoritesViewController, router: FavoritesRouter)
    func getFavorites() -> [Character]
}

class FavoritesViewModel: FavoritesViewModelProtocol {
    // MARK: - Variables
    var view: FavoritesViewController?
    var router: FavoritesRouter?
    private var dataManager = DataManager()

    // MARK: - Connecting view and router
    func bind(view: FavoritesViewController, router: FavoritesRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }

    // MARK: - Get data from service
    func getFavorites() -> [Character] {
        return dataManager.getFavorites()
    }

    // MARK: - Navigation
    func createCharacterDetailView(_ character: Character) {
        router?.navigateToCharacterDetail(character)
    }
}
