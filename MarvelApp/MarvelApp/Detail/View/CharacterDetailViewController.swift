//
//  CharacterDetailViewController.swift
//  MarvelApp
//
//  Created by crodrigueza on 16/2/22.
//

import UIKit

protocol CharacterDetailViewControllerProtocol {
    func configureCharacterDetailView()
}

class CharacterDetailViewController: UIViewController, CharacterDetailViewControllerProtocol {
    // MARK: - Outlets
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!

    // MARK: - Variables
    private var router = CharacterDetailRouter()
    private var viewModel = CharacterDetailViewModel()
    var character: Character?
    var isHiddenFavoriteButton: Bool?

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureCharacterDetailView()
        viewModel.bind(view: self, router: router)
    }

    // MARK: - NavigationItem configuration
    private func configureNavigationItem() {
        navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationItem.title = Constants.appName
    }

    // MARK: View configuration
    func configureCharacterDetailView() {
        guard let character = character else { return }
        self.characterImageView.getImageFromURL(character.thumbnail.path, .portrait_incredible, character.thumbnail.imageExtension)
        self.titleLabel.text = character.name
        if character.description == "" {
            self.descriptionLabel.text = "*No info*"
        } else {
            self.descriptionLabel.text = character.description
        }
        configureFavoriteButton()
    }

    func configureFavoriteButton() {
        self.favoriteButton.isHidden = isHiddenFavoriteButton ?? false
        self.favoriteButton.backgroundColor = .red
        self.favoriteButton.tintColor = .black
        self.favoriteButton.setTitle("Favorite", for: .normal)
        self.favoriteButton.addTarget(self, action: #selector(didPressFavoriteButton), for: .touchUpInside)
    }

    // MARK: - Button action
    @objc func didPressFavoriteButton() {
        saveFavorite()
    }

    private func saveFavorite() {
        guard let character = character else { return }
        viewModel.saveFavorite(character)
    }
}
