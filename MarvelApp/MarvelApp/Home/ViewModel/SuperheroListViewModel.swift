//
//  SuperheroListViewModel.swift
//  MarvelApp
//
//  Created by crodrigueza on 16/2/22.
//

import Foundation
import RxSwift

protocol SuperheroListViewModelProtocol {
    var view: SuperheroListViewControllerProtocol? { get set }
    var router: SuperheroListRouterProtocol? { get set }
    func bind(view: SuperheroListViewControllerProtocol, router: SuperheroListRouterProtocol)
    func getSuperheroes() -> Observable<[Superhero]>
    func createSuperheroDetailView(_ superhero: Superhero)
}

class SuperheroListViewModel: SuperheroListViewModelProtocol {
    // MARK: - Variables
    var view: SuperheroListViewControllerProtocol?
    var router: SuperheroListRouterProtocol?
    private var networkManager = NetworkManager()

    // MARK: - Connecting view and router
    func bind(view: SuperheroListViewControllerProtocol, router: SuperheroListRouterProtocol) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view as? UIViewController)
    }

    // MARK: - Get data from service
    func getSuperheroes() -> Observable<[Superhero]> {
        return networkManager.getSuperheroes()
    }

    // MARK: - Navigat
    func createSuperheroDetailView(_ superhero: Superhero) {
        router?.navigateToSuperheroDetail(superhero)
    }
}
