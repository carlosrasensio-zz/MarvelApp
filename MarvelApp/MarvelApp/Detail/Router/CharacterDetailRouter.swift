//
//  CharacterDetailRouter.swift
//  MarvelApp
//
//  Created by crodrigueza on 16/2/22.
//

import Foundation
import UIKit

protocol CharacterDetailRouterProtocol {
    var character: Character? { get }
    func createCharacterDetailViewController() -> UIViewController
    func setSourceView(_  sourceView: UIViewController?)
}

class CharacterDetailRouter: CharacterDetailRouterProtocol {
    // MARK: - Variables
    private var sourceView: UIViewController?
    var viewController: UIViewController {
        createCharacterDetailViewController()
    }
    var character: Character?

    // MARK: - Initializer
    init(character: Character? = nil) {
        self.character = character
    }

    // MARK: - Configuration functions
    func createCharacterDetailViewController() -> UIViewController {
        let view = CharacterDetailViewController(nibName: "CharacterDetailViewController", bundle: Bundle.main)
        view.character = character

        return view
    }

    func setSourceView(_  sourceView: UIViewController?) {
        guard let view = sourceView else { return }
        self.sourceView = view
    }
}
