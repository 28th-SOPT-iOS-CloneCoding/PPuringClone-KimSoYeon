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
                
                townLabel.font = .boldSystemFont(ofSize: 15)
                townLabel.textColor = .systemRed
                
            } else {
                buttonView.backgroundColor = .systemGray6
                buttonView.layer.borderColor = UIColor.systemGray5.cgColor
                
                townLabel.font = .systemFont(ofSize: 15)
                townLabel.textColor = .darkGray
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        townLabel.font = UIFont.systemFont(ofSize: 15)
    }
    
    func setTown(town: String) {
        townLabel.text = town
    }

}
