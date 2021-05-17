//
//  MovieTVC.swift
//  CGVMovieApp
//
//  Created by soyeon on 2021/05/14.
//

import UIKit
import Kingfisher

class MovieListTVC: UITableViewCell {
    static let identifier = "MovieListTVC"

    private lazy var posterImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage()
        imageView.image = image
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 1
        return label
    }()

    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    private let popularityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.red
        return label
    }()

    private let voteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.lightGray
        return label
    }()

    private let reservationButton: UIButton = {
        let button = UIButton()
        button.setTitle("지금 예매", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.tintColor = .white
        button.backgroundColor = UIColor(red: 185/255, green: 51/255, blue: 49/255, alpha: 1)
        return button
    }()

    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    override func updateConstraints() {
        layoutIfNeeded()
        super.updateConstraints()
        
        reservationButton.layer.cornerRadius = 3
    }
    
    func setValue(title: String, poster: String, release: String, isAdult: Bool, popularity: Double, voteCount: Int, voteAvg: Double) {
        titleLabel.text = title
        
        let string = "https://image.tmdb.org/t/p/w500/\(poster)"
        let url = URL(string: string)!
        posterImage.kf.setImage(with: url)
       
        popularityLabel.text = "예매율 \(voteAvg)"
        voteLabel.text = "누적관객 \(voteCount)"

        let date = release.replacingOccurrences(of: "-", with: ".")
        releaseDateLabel.text = "\(date) 개봉"

        let attributedStr = NSMutableAttributedString(string: popularityLabel.text!)

        attributedStr.addAttribute(.foregroundColor, value: UIColor.black, range: (popularityLabel.text! as NSString).range(of: "예매율"))
        popularityLabel.attributedText = attributedStr
    }

    func setConstraints() {
        contentView.addSubview(posterImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(popularityLabel)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(reservationButton)
        contentView.addSubview(voteLabel)

        posterImage.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(110)
            make.top.equalTo(contentView.snp.top).inset(10)
            make.leading.equalTo(contentView.snp.leading).inset(10)
            make.bottom.equalTo(contentView.snp.bottom).inset(10)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.top).inset(8)
            make.leading.equalTo(posterImage.snp.trailing).inset(-10)
        }

        popularityLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-5)
            make.leading.equalTo(titleLabel.snp.leading)
        }

        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(popularityLabel.snp.bottom).inset(-3)
            make.leading.equalTo(titleLabel.snp.leading)
        }

        voteLabel.snp.makeConstraints { make in
            make.top.equalTo(releaseDateLabel.snp.bottom).inset(-3)
            make.leading.equalTo(titleLabel.snp.leading)
        }

        reservationButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.width.equalTo(50)
            make.bottom.equalTo(posterImage.snp.bottom)
        }
    }
}


