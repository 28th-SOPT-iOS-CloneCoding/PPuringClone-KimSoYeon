//
//  StoryListTVC.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/05/26.
//

import UIKit

class StoryListTVC: UITableViewCell {
    static let identifier = "StoryListTVC"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension StoryListTVC {
    func setUI() {
        titleLabel.font = UIFont.NotoSerif(.semiBold, size: 15)
        titleLabel.textColor = .darkGray
        titleLabel.text = "글"
        
        dateLabel.font = UIFont.NotoSerif(.light, size: 15)
        dateLabel.textColor = .lightGray
        dateLabel.text = "05.28"
    }
}
