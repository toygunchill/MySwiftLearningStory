//
//  MovieCell.swift
//  MovieAppCase
//
//  Created by Toygun Çil on 26.09.2022.
//

import UIKit
import Kingfisher


class MovieCell: UITableViewCell {

    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureMovieListScreen(with searchMovies: [Movie?], indexPath: IndexPath) {
        movieNameLabel.text = searchMovies[indexPath.row]?.Title
        movieYearLabel.text = searchMovies[indexPath.row]?.Year
        if let imageString = searchMovies[indexPath.row]?.Poster {
            let imageUrl = URL(string: imageString)
            movieImageView.kf.setImage(with: imageUrl)
        }
    }
}
