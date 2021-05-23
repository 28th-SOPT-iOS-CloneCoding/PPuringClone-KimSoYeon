//
//  TheaterTownCVC.swift
//  CGVMovieApp
//
//  Created by soyeon on 2021/05/18.
//

import UIKit

class TheaterTownCVC: UICollectionViewCell {
    static let identifier = "TheaterTownCVC"
    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var townLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                buttonView.backgroundColor = .white
                buttonView.layer.borderColor = UIColor.systemRed.cgColor
                self.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
                
                townLabel.font = .boldSystemFont(ofSize: 15)
                townLabel.textColor = .systemRed
                
            } else {
                buttonView.backgroundColor = .systemGray6
                buttonView.layer.borderColor = UIColor.systemGray5.cgColor
                self.layer.shadowColor = UIColor.white.cgColor
                
                townLabel.font = .systemFont(ofSize: 15)
                townLabel.textColor = .darkGray
            }
            buttonView.layer.borderWidth = 1
            buttonView.layer.cornerRadius = 10
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        townLabel.font = UIFont.systemFont(ofSize: 15)
        self.setViewShadow(backView: buttonView)
    }
    
    func setTown(town: String) {
        townLabel.text = town
    }

}
