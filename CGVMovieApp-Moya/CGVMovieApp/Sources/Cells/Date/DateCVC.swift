//
//  DateCVC.swift
//  CGVMovieApp
//
//  Created by soyeon on 2021/05/18.
//

import UIKit

class DateCVC: UICollectionViewCell {
    static let identifier = "DateCVC"
    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
                
                buttonView.backgroundColor = .white
                buttonView.layer.borderColor = UIColor.systemRed.cgColor
                
                dateLabel.font = .boldSystemFont(ofSize: 15)
                dateLabel.textColor = .systemRed
                
                dayLabel.font = .systemFont(ofSize: 10)
                dayLabel.textColor = .systemRed
            } else {
                self.layer.shadowColor = UIColor.white.cgColor
                
                buttonView.layer.borderColor = UIColor.systemGray5.cgColor
                
                dateLabel.font = .systemFont(ofSize: 15)
                dateLabel.textColor = .darkGray
                
                dayLabel.font = .systemFont(ofSize: 10)
                dayLabel.textColor = .darkGray
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateLabel.font = UIFont.systemFont(ofSize: 15)
        dayLabel.font = UIFont.systemFont(ofSize: 10)
    }
    
    func setDate(date: String, day: String) {
        dateLabel.text = date
        dayLabel.text = day
    }
}
