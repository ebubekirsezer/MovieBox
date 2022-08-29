//
//  MovieCell.swift
//  MovieBox
//
//  Created by EbubekirSezer on 28.08.2022.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {
    
    static let REUSE_ID = "MovieCell"
    
    @IBOutlet private weak var imageViewPoster: UIImageView?
    @IBOutlet private weak var labelTitle: UILabel?
    @IBOutlet private weak var labelReleaseYear: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupWith(movie: Movie) {
        let placeholderImage = UIImage(named: "noImage")
        imageViewPoster?.kf.setImage(with: URL(string: movie.poster ?? ""), placeholder: placeholderImage)
        labelTitle?.text = movie.title
        labelReleaseYear?.text = movie.year
    }
}
