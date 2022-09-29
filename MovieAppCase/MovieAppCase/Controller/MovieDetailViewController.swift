//
//  MovieDetailViewController.swift
//  MovieAppCase
//
//  Created by Toygun Çil on 27.09.2022.
//

import UIKit
import TransitionButton
import Kingfisher

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var moviePlotLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var movieActorsLabel: UILabel!
    @IBOutlet weak var movieImdbVotingLabel: UILabel!
    @IBOutlet weak var movieImdbRatingLabel: UILabel!
    @IBOutlet weak var movieCountryLabel: UILabel!
    @IBOutlet weak var movieLanguageLabel: UILabel!
    @IBOutlet weak var movieWriterLabel: UILabel!
    @IBOutlet weak var movieDirectorLabel: UILabel!
    @IBOutlet weak var movieRuntimeLabel: UILabel!
    @IBOutlet weak var movieReleasedLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    

    let button = TransitionButton(frame: CGRect(x: 170, y: 400, width: 50, height: 50))
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var loadingControl = "True"
    
    func loadingAnimation() {
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 12
        view.addSubview(button)
        button.startAnimation()
    }
    
    func configureDetailNetwork(with movieId: String?) {
        loadingAnimation()
        Network.sharedNetwork.getDetailData(with: movieId) { detailResult in
            switch detailResult {
            case .success(let detailResponse):
                DispatchQueue.main.async {
                    if let title = detailResponse.Title {
                        self.movieNameLabel.text = "Title: \(String(describing: title))"
                    }
                    if let year = detailResponse.Year {
                        self.movieYearLabel.text = "Year: \(String(describing: year))"
                    }
                    if let released = detailResponse.Released {
                        self.movieReleasedLabel.text = "Released: \(String(describing: released))"
                    }
                    if let runtime = detailResponse.Runtime {
                        self.movieRuntimeLabel.text = "Runtime: \(String(describing: runtime))"
                    }
                    if let director = detailResponse.Director {
                        self.movieDirectorLabel.text = "Director: \(String(describing: director))"
                    }
                    if let writer = detailResponse.Writer {
                        self.movieWriterLabel.text = "Writer: \(String(describing: writer))"
                    }
                    if let language = detailResponse.Language {
                        self.movieLanguageLabel.text = "Language: \(String(describing: language))"
                    }
                    if let country = detailResponse.Country {
                        self.movieCountryLabel.text = "Country: \(String(describing: country))"
                    }
                    if let rating = detailResponse.imdbRating {
                        self.movieImdbRatingLabel.text = "IMDB Rating: \(String(describing: rating))"
                    }
                    if let voting = detailResponse.imdbVoting {
                        self.movieImdbVotingLabel.text = "IMDB Voting: \(String(describing: voting))"
                    }
                    if let actors = detailResponse.Actors {
                        self.movieActorsLabel.text = "Actor: \(String(describing: actors))"
                    }
                    if let genre = detailResponse.Genre {
                        self.movieGenreLabel.text = "Genre: \(String(describing: genre))"
                    }
                    if let plot = detailResponse.Plot {
                        self.moviePlotLabel.text = "Plot: \(String(describing: plot))"
                    }
                    if let imageString = detailResponse.Poster {
                        let imageUrl = URL(string: imageString)
                        self.movieImageView.kf.setImage(with: imageUrl)
                        self.loadingControl = "False"
                        self.button.stopAnimation(animationStyle: .expand, revertAfterDelay: 0.3)
                        sleep(1)
                        self.button.isHidden = true
                    }
                }
            case .failure(let detailError):
                let alert = UIAlertController(title: "Alert", message: "Searched Movie's Details Could Not Be Listed", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print(detailError)
            }
        }
    }
}
