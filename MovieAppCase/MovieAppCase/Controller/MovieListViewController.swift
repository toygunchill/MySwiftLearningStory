//
//  ViewController.swift
//  MovieAppCase
//
//  Created by Toygun Çil on 21.09.2022.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var movieSearchBar: UISearchBar! {
        didSet {
            movieSearchBar.showsCancelButton = true
            movieSearchBar.delegate = self
        }
    }
    @IBOutlet weak var movieTableView: UITableView! {
        didSet {
            movieTableView.dataSource = self
            movieTableView.delegate = self
            movieTableView.register(UINib(nibName: String(describing: MovieCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MovieCell.self))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let searchMovieName: String? = ""
    var pageNumber: Int? = 1
    var removeControll: String? = "false"
    var searchText: String? = "" {
        didSet {
            movieTableView.reloadData()
        }
    }
    var searchMovies: [Movie?] = [] {
        didSet {
            movieTableView.reloadData()
        }
    }
    
    func configureSearchNetwork(with searchText: String?) {
        Network.sharedNetwork.getSearchData(with: searchText) { searchResult in
            switch searchResult {
            case .success(let searchResponse):
                DispatchQueue.main.async {
                    if let searchResp = searchResponse.Search {
                        self.searchMovies.append(contentsOf: searchResp)
                    }
                }
            case .failure(let searchError):
                let alert = UIAlertController(title: "Alert", message: "Searched Movies Could Not Be Listed", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print(searchError)
            }
        }
    }
}

extension MovieListViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchMovies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCell = movieTableView.dequeueReusableCell(withIdentifier: String(describing: MovieCell.self), for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        movieCell.configureMovieListScreen(with: searchMovies, indexPath: indexPath)
        return movieCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movieDetailVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
            self.navigationController?.pushViewController(movieDetailVC, animated: true)
            movieDetailVC.configureDetailNetwork(with: searchMovies[indexPath.row]?.imdbID)
        }
    }
}

extension MovieListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = movieSearchBar.text!
        if (searchText.count >= 3) {
            pageNumber = 1
            searchMovies.removeAll()
            configureSearchNetwork(with: searchText)
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchMovies.removeAll()
    }
}

