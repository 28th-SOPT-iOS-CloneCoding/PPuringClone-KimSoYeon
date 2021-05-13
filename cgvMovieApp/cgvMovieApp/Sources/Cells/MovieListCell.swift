//
//  MovieListCell.swift
//  cgvMovieApp
//
//  Created by soyeon on 2021/05/10.
//

import UIKit

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
        
        initialSetUp()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCellWithValuesOf(_ movie: Movie) {
        updateUI(title: movie.title, releaseDate: movie.year, rating: movie.rate, poster: movie.posterImage, adult: movie.adult)
    }
    
    func initialSetUp() {
        adultMark.isHidden = true
        nowReserve.layer.cornerRadius = 3
    }
    
    // MARK: - Update UI Views
    private func updateUI(title: String?, releaseDate: String?, rating: Double?, poster: String?, adult: Bool?) {
        self.titleLabel.text = title
        self.releaseDateLabel.text = convertDateFormatter(releaseDate)
        
        guard let rate = rating else {return}
        self.ticketSaleLabel.text = "예매율 \(String(rate))%"
        
        if adult! {
            self.adultMark.isHidden = true
        } else {
            self.adultMark.isHidden = false
        }
        
        guard let posterString = poster else {return}
        urlString = "http://image.tmdb.org/t/p/w300" + posterString
        guard let posterImageURL = URL(string: urlString) else {
            self.posterImageView.image = UIImage(named: "No Image")
            return
        }
        self.posterImageView.image = nil
        getImageDateFrom(url: posterImageURL)
    }
    
    // MARK: - Get image data
    private func getImageDateFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, responds, error) in
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.posterImageView.image = image
                }
            }
        }.resume()
    }
    
    // MARK: - Convert date format
    func convertDateFormatter(_ date: String?) -> String {
        var fixDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let originalDate = date {
            if let newData = dateFormatter.date(from: originalDate) {
                dateFormatter.dateFormat = "yyyy.MM.dd 개봉"
                fixDate = dateFormatter.string(from: newData)
            }
        }
        return fixDate
    }
}
