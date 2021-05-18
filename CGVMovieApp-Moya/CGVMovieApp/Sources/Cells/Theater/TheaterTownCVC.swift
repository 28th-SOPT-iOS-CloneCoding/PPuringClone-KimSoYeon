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
                self.townLabel.textColor = isSelected ? UIColor.systemRed : UIColor.darkGray
                self.townLabel.font = isSelected ? .boldSystemFont(ofSize: 15) : .systemFont(ofSize: 15)
                self.buttonView.layer.borderColor = isSelected ? UIColor.systemRed.cgColor : UIColor.systemGray4.cgColor
                self.buttonView.backgroundColor = isSelected ? .white : .systemGray6
                self.layer.shadowColor = isSelected ? UIColor.black.withAlphaComponent(0.3).cgColor : UIColor.white.cgColor
            }
        }
        
        override func awakeFromNib() {
            super.awakeFromNib()
            setUI()
        }
}

extension TheaterTownCVC {
    private func setUI() {
        
    }
    
    func labelConfigure(position: String) {
        townLabel.text = position
    }
}
