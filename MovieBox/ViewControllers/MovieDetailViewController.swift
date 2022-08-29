//
//  MovieDetailViewController.swift
//  MovieBox
//
//  Created by EbubekirSezer on 29.08.2022.
//

import Foundation
import UIKit

final class MovieDetailViewController: BaseViewController {
    
    @IBOutlet private weak var imageViewPoster: UIImageView?
    @IBOutlet private weak var labelTitle: UILabel?
    @IBOutlet private weak var labelDetail: UILabel?
    @IBOutlet private weak var labelReleaseDate: UILabel?
    @IBOutlet private weak var labelGenre: UILabel?
    @IBOutlet private weak var labelActors: UILabel?
    @IBOutlet private weak var labelDirectors: UILabel?
    @IBOutlet private weak var labelLanguage: UILabel?
    @IBOutlet private weak var labelCountry: UILabel?
    @IBOutlet private weak var labelIMBDRating: UILabel?
    
    private var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func initiliazeWith(movie: Movie?) {
        self.movie = movie
    }
    
    private func setupUI() {
        let placeholderImage = UIImage(named: "noImage")
        imageViewPoster?.kf.setImage(with: URL(string: movie?.poster ?? ""), placeholder: placeholderImage)
        labelTitle?.text = movie?.title
        labelDetail?.text = movie?.plot
        labelReleaseDate?.text = "Release Date: \(movie?.released ?? "")"
        labelGenre?.text = "Genre: \(movie?.genre ?? "")"
        labelActors?.text = "Actors: \(movie?.actors ?? "")"
        labelDirectors?.text = "Directors: \(movie?.director ?? "")"
        labelLanguage?.text = "Language: \(movie?.language ?? "")"
        labelCountry?.text = "Country: \(movie?.country ?? "")"
        labelIMBDRating?.text = "IMDB Rate: \(movie?.imdbRating ?? "")"
    }
}
