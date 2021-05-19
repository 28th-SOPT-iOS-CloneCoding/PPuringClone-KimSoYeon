//
//  TimeCVC.swift
//  CGVMovieApp
//
//  Created by soyeon on 2021/05/18.
//

import UIKit

class TimeCVC: UICollectionViewCell {
    static let identifier = "TimeCVC"
    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
                
                buttonView.backgroundColor = .white
                buttonView.layer.borderColor = UIColor.systemRed.cgColor
                
                timeLabel.font = .boldSystemFont(ofSize: 15)
                timeLabel.textColor = .systemRed
            } else {
                self.layer.shadowColor = UIColor.white.cgColor
                
                buttonView.backgroundColor = .systemGray6
                buttonView.layer.borderColor = UIColor.systemGray5.cgColor
                
                timeLabel.font = .systemFont(ofSize: 15)
                timeLabel.textColor = .darkGray
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        timeLabel.font = UIFont.systemFont(ofSize: 15)
    }
    
    func setTime(time: String) {
        timeLabel.text = time
    }
    
}
