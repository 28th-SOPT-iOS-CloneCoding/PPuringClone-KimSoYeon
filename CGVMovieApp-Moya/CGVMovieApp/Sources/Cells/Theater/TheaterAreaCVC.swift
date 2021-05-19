//
//  TheaterAreaCVC.swift
//  CGVMovieApp
//
//  Created by soyeon on 2021/05/18.
//

import UIKit
import SnapKit

class TheaterAreaCVC: UICollectionViewCell {
    static let identifier = "TheaterAreaCVC"
    
    @IBOutlet weak var areaLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                areaLabel.textColor = .systemRed
            } else {
                areaLabel.textColor = .darkGray
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        areaLabel.font = UIFont.systemFont(ofSize: 15)
    }
    
    func setArea(area: String) {
        areaLabel.text = area
    }
}
