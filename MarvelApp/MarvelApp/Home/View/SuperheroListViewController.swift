//
//  SuperheroListViewController.swift
//  MarvelApp
//
//  Created by crodrigueza on 16/2/22.
//

import UIKit

class SuperheroListViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view configuration
    func setTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    // MARK: - Activity indicator configuraion
    func setActivityIndicator() {

    }


}

// MARK: - TableView functions
extension SuperheroListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CustomCells.movieCellId) as! MovieCustomCell
        if searchController.isActive && searchController.searchBar.text != "" {
            cell.titleLabel.text = filteredMovies[indexPath.row].title
            cell.descriptionLabel.text = filteredMovies[indexPath.row].description
            cell.voteAverageLabel.text = "Vote average: \(filteredMovies[indexPath.row].voteAverage)"
            let imageUrl = Constants.NetworkManager.URLs.image + filteredMovies[indexPath.row].image
            cell.movieImageView.getImageFromURL(urlString: imageUrl)
        } else {
            cell.titleLabel.text = movies[indexPath.row].title
            cell.descriptionLabel.text = movies[indexPath.row].description
            cell.voteAverageLabel.text = "Vote average: \(movies[indexPath.row].voteAverage)"
            let imageUrl = Constants.NetworkManager.URLs.image + movies[indexPath.row].image
            cell.movieImageView.getImageFromURL(urlString: imageUrl)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension SuperheroListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.isActive && searchController.searchBar.text != "" {
            viewModel.createMovieDetailView(movie: filteredMovies[indexPath.row])
        } else {
            viewModel.createMovieDetailView(movie: movies[indexPath.row])
        }
    }
}
