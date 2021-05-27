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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension StoryListTVC {
    func setData() {
        
    }
}
