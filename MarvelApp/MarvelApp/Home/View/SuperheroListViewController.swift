//
//  SuperheroListViewController.swift
//  MarvelApp
//
//  Created by crodrigueza on 16/2/22.
//

import UIKit
import RxSwift
import RxCocoa

protocol SuperheroListViewControllerProtocol {
    func setTableView()
    func getSuperheroes()
}

class SuperheroListViewController: UIViewController, SuperheroListViewControllerProtocol {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Variables
    private var router = SuperheroListRouter()
    private var viewModel = SuperheroListViewModel()
    private var superheroes = [Superhero]()
    private var disposeBag = DisposeBag()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        getSuperheroes()
    }

    // MARK: - Table view configuration
    func setTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: Constants.CustomCells.superheroCellId, bundle: nil), forCellReuseIdentifier: Constants.CustomCells.superheroCellId)
        tableView.separatorColor = .red
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
extension SuperheroListViewController {
    func getSuperheroes() {
        setActivityIndicator(true)
        return viewModel.getSuperheroes()
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe { superheroes in
                self.superheroes = superheroes
                self.reloadTableView()
            } onError: { error in
                print("\n[X] Error: \(error.localizedDescription)\n")
                self.showAlert(title: "ERROR", message: error.localizedDescription)
            } onCompleted: {}
            .disposed(by: disposeBag)
    }
}

// MARK: - TableView functions
extension SuperheroListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return superheroes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CustomCells.superheroCellId) as! SuperheroCustomCell
        cell.titleLabel.text = superheroes[indexPath.row].name
        cell.descriptionLabel.text = superheroes[indexPath.row].description
        let imagePath = superheroes[indexPath.row].thumbnail.path
        let imageExtension = superheroes[indexPath.row].thumbnail.imageExtension
        cell.superheroImageView.getImageFromURL(imagePath, .portrait_xlarge, imageExtension)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension SuperheroListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

// MARK: - Alerts configuration
private extension SuperheroListViewController {
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
