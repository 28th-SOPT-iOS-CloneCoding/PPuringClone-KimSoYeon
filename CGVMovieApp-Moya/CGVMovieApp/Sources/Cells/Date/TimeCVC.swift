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
                
            }
        }
    }
    
}
