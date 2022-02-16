//
//  SuperheroDetailRouter.swift
//  MarvelApp
//
//  Created by crodrigueza on 16/2/22.
//

import Foundation
import UIKit

protocol SuperheroListRouterProtocol {
    func createSuperheroListViewController() -> UIViewController
    func setSourceView(_  sourceView: UIViewController?)
    func navigateToSuperheroDetail(_ superhero: Superhero)
}

class SuperheroListRouter: SuperheroListRouterProtocol {
    // MARK: - Variables
    private var sourceView: UIViewController?
    var viewController: UIViewController {
        createSuperheroListViewController()
    }

    // MARK: - Configuration functions
    func createSuperheroListViewController() -> UIViewController {
        let view = SuperheroListViewController(nibName: "SuperheroListViewController", bundle: Bundle.main)

        return view
    }

    func setSourceView(_  sourceView: UIViewController?) {
        guard let view = sourceView else { return }
        self.sourceView = view
    }

    // MARK: - Navigation function
    func navigateToSuperheroDetail(_ superhero: Superhero) {
//        let superheroDetailView = SuperheroDetailRouter(superhero: superhero).viewController
//        sourceView?.navigationController?.pushViewController(superheroDetailView, animated: true)
    }
}
