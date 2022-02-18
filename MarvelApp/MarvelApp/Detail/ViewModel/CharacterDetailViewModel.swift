//
//  CharacterDetailViewModel.swift
//  MarvelApp
//
//  Created by crodrigueza on 16/2/22.
//

import Foundation
import RxSwift

protocol CharacterDetailViewModelProtocol {
    var view: CharacterDetailViewController? { get set }
    var router: CharacterDetailRouter? { get set }
    func bind(view: CharacterDetailViewController, router: CharacterDetailRouter)
}

class CharacterDetailViewModel: CharacterDetailViewModelProtocol {
    // MARK: - Variables
    var view: CharacterDetailViewController?
    var router: CharacterDetailRouter?

    // MARK: - Connecting view and router
    func bind(view: CharacterDetailViewController, router: CharacterDetailRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
}
