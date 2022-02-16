//
//  SuperheroListViewController.swift
//  MarvelApp
//
//  Created by crodrigueza on 16/2/22.
//

import UIKit

protocol SuperheroListViewControllerProtocol {
    func setTableView()
    func getSuperheroes()
}

class SuperheroListViewController: UIViewController, SuperheroListViewControllerProtocol {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Variables
    private var superheroes = [Superhero]()

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
    }

    private func reloadTableView() {
        DispatchQueue.main.async {
            self.setActivityIndicator(false)
            self.tableView.reloadData()
        }
    }

    // MARK: - Activity indicator configuraion
    private func setActivityIndicator(_ show: Bool) {
        self.activityIndicator.isHidden = !show
        if show {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
    }

    // MARK: - Get data
    func getSuperheroes() {
        // TODO: call view model method
    }
}

// MARK: - TableView functions
extension SuperheroListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CustomCells.superheroCellId) as! SuperheroCustomCell
        let exampleSuperhero = Superhero(name: "Iron Man", description: "Avenger")
        cell.titleLabel.text = exampleSuperhero.name
        cell.descriptionLabel.text = exampleSuperhero.description
        cell.superheroImageView.image = UIImage(named: Constants.appIcon)

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
