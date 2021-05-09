//
//  AlarmRepeatCell.swift
//  ClockApp
//
//  Created by soyeon on 2021/05/03.
//

import UIKit

class AlarmRepeatCell: UITableViewCell {
    static let identifier = "AlarmRepeatCell"

    @IBOutlet weak var repeatLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setRepeatLabel(label: [String]) {
        var str = " "
        if label.isEmpty {
            repeatLabel.text = "안함"
        } else {
            for t in label {
                str = str + "\(t)요일마다"
            }
            repeatLabel.text = str
        }
    }

}
