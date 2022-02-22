//
//  FavoritesViewController.swift
//  MarvelApp
//
//  Created by crodrigueza on 22/2/22.
//

import UIKit

protocol FavoritesViewControllerProtocol {
    func configureTableView()
    func getFavorites()
}

class FavoritesViewController: UIViewController, FavoritesViewControllerProtocol {
    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Variables
    private var router = FavoritesRouter()
    private var viewModel = FavoritesViewModel()
    var favorites = [Character]()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureTableView()
        viewModel.bind(view: self, router: router)
        getFavorites()
    }

    // MARK: - NavigationItem configuration
    private func configureNavigationItem() {
        navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationItem.title = "Favorites"
        navigationItem.rightBarButtonItem?.tintColor = .black
    }

    // MARK: - Table view configuration
    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: Constants.CustomCells.characterCellId, bundle: nil), forCellReuseIdentifier: Constants.CustomCells.characterCellId)
    }

    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - Get data from ViewModel with RxSwift
extension FavoritesViewController {
    func getFavorites() {
        self.favorites = viewModel.getFavorites()
        self.reloadTableView()
    }
}

// MARK: - TableView functions
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CustomCells.characterCellId) as! CharacterCustomCell
        cell.titleLabel.text = favorites[indexPath.row].name
        let imagePath = favorites[indexPath.row].thumbnail.path
        let imageExtension = favorites[indexPath.row].thumbnail.imageExtension
        cell.characterImageView.getImageFromURL(imagePath, .landscape_amazing, imageExtension)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.createCharacterDetailView(favorites[indexPath.row])
    }
}
