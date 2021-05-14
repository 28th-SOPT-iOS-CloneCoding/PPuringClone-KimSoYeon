//
//  MovieListCell.swift
//  cgvMovieApp
//
//  Created by soyeon on 2021/05/10.
//

import UIKit
import Kingfisher

class MovieListCell: UITableViewCell {
    static let identifier = "MovieListCell"

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ticketSaleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var nowReserve: UIButton!
    @IBOutlet weak var adultMark: UIButton!
    
    private var urlString: String = ""
    private var isAdult: Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        adultMark.isHidden = true
        nowReserve.layer.cornerRadius = 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCellWithValuesOf(_ movie: Movie) {
        updateUI(title: movie.title, releaseDate: movie.year, rating: movie.rate, poster: movie.posterImage, adult: movie.adult)
    }

    // MARK: - Update UI Views
    private func updateUI(title: String?, releaseDate: String?, rating: Double?, poster: String?, adult: Bool?) {
        self.titleLabel.text = title
        self.releaseDateLabel.text = releaseDate?.replacingOccurrences(of: "-", with: ".")
        
        guard let rate = rating else {return}
        self.ticketSaleLabel.text = "예매율 \(String(rate))%"
        
        if adult! {
            self.adultMark.isHidden = true
        } else {
            self.adultMark.isHidden = false
        }
        
        guard let posterString = poster else {return}
        let string = "https://image.tmdb.org/t/p/w500/\(posterString)"
        let url = URL(string: string)!
        posterImageView.kf.setImage(with: url)
    }
    
}
