//
//  CharacterListViewController.swift
//  MarvelApp
//
//  Created by crodrigueza on 16/2/22.
//

import UIKit
import RxSwift
import RxCocoa

protocol CharacterListViewControllerProtocol {
    func setTableView()
    func getCharacters()
}

class CharacterListViewController: UIViewController, CharacterListViewControllerProtocol {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Variables
    private var router = CharacterListRouter()
    private var viewModel = CharacterListViewModel()
    private var characters = [Character]()
    private var filteredCharacters = [Character]()
    private var disposeBag = DisposeBag()

    lazy var searchController: UISearchController = ({
        createSearchBarController()
    })()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureSearchBarController()
        setTableView()
        getCharacters()
    }

    // MARK: - NavigationItem configuration
    private func configureNavigationItem() {
        navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationItem.title = Constants.appName
    }

    // MARK: - SearchBarController configuration
    private func createSearchBarController() -> UISearchController {
        let controller = UISearchController(searchResultsController: nil)
        controller.hidesNavigationBarDuringPresentation = true
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.sizeToFit()
        controller.searchBar.barStyle = .default
        controller.searchBar.backgroundColor = .red
        controller.searchBar.placeholder = "Search your MARVEL character!"
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
         UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes, for: .normal)

        return controller
    }

    private func configureSearchBarController() {
        let searchBar = searchController.searchBar
        searchController.delegate = self
        tableView.tableHeaderView = searchBar
        tableView.contentOffset = CGPoint(x: 0, y: searchBar.frame.size.height)
        searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe { result in
                self.filteredCharacters = self.characters.filter({ character in
                    self.reloadTableView()
                    return character.name.contains(result)
                })
            } onError: { error in
                print("\n[X] Error: \(error.localizedDescription)\n")
                self.showAlert(title: "ERROR", message: error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }

    // MARK: - Table view configuration
    func setTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: Constants.CustomCells.characterCellId, bundle: nil), forCellReuseIdentifier: Constants.CustomCells.characterCellId)
    }

    private func reloadTableView() {
        DispatchQueue.main.async {
            self.setActivityIndicator(false)
            self.tableView.reloadData()
        }
    }

    // MARK: - Activity indicator configuraion
    private func setActivityIndicator(_ show: Bool) {
        if show {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
        self.activityIndicator.isHidden = !show
    }
}

// MARK: - Get data from ViewModel with RxSwift
extension CharacterListViewController {
    func getCharacters() {
        setActivityIndicator(true)
        return viewModel.getCharacters()
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe { characters in
                self.characters = characters
                self.reloadTableView()
            } onError: { error in
                print("\n[X] Error: \(error.localizedDescription)\n")
                self.showAlert(title: "ERROR", message: error.localizedDescription)
            } onCompleted: {}
            .disposed(by: disposeBag)
    }
}

// MARK: - TableView functions
extension CharacterListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredCharacters.count
        } else {
            return characters.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CustomCells.characterCellId) as! CharacterCustomCell
        if searchController.isActive && searchController.searchBar.text != "" {
            cell.titleLabel.text = filteredCharacters[indexPath.row].name
            let imagePath = filteredCharacters[indexPath.row].thumbnail.path
            let imageExtension = filteredCharacters[indexPath.row].thumbnail.imageExtension
            cell.characterImageView.getImageFromURL(imagePath, .landscape_amazing, imageExtension)
        } else {
            cell.titleLabel.text = characters[indexPath.row].name
            let imagePath = characters[indexPath.row].thumbnail.path
            let imageExtension = characters[indexPath.row].thumbnail.imageExtension
            cell.characterImageView.getImageFromURL(imagePath, .landscape_amazing, imageExtension)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.isActive && searchController.searchBar.text != "" {
        } else {
        }
    }
}

// MARK: - SearchController functions
extension CharacterListViewController: UISearchControllerDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        reloadTableView()
    }
}

// MARK: - Alerts configuration
private extension CharacterListViewController {
    func showAlert(title: String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .red
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            alert.dismiss(animated: true)
        }
    }
}
