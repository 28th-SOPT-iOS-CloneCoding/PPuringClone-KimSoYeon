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
                buttonView.backgroundColor = .white
                buttonView.layer.borderColor = UIColor.systemRed.cgColor
                self.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
                
                timeLabel.font = .boldSystemFont(ofSize: 15)
                timeLabel.textColor = .systemRed
            } else {
                buttonView.backgroundColor = .systemGray6
                buttonView.layer.borderColor = UIColor.systemGray5.cgColor
                self.layer.shadowColor = UIColor.white.cgColor
                
                timeLabel.font = .systemFont(ofSize: 15)
                timeLabel.textColor = .darkGray
            }
            buttonView.layer.borderWidth = 1
            buttonView.layer.cornerRadius = 10
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
