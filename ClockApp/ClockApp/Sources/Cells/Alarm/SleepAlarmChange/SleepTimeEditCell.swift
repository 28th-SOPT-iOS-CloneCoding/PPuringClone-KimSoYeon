//
//  SleepTimeEditCell.swift
//  ClockApp
//
//  Created by soyeon on 2021/05/07.
//

import UIKit

class SleepTimeEditCell: UITableViewCell {
    static let identifier = "SleepTimeEditCell"
    
    @IBOutlet weak var timeEditButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
