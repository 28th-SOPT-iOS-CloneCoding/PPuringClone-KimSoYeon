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
            self.areaLabel.textColor = isSelected ? UIColor.systemRed : UIColor.gray
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLabel()
    }
    
    func areaConfigure(area: String) {
        areaLabel.text = area
    }
    
    private func setLabel() {
        areaLabel.font = .systemFont(ofSize: 15)
    }
}
