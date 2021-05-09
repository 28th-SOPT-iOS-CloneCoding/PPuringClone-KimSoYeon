//
//  AlarmLabelCell.swift
//  ClockApp
//
//  Created by soyeon on 2021/05/03.
//

import UIKit

class AlarmLabelCell: UITableViewCell {
    static let identifier = "AlarmLabelCell"

    @IBOutlet weak var labelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setLabel(label: String) {
        labelLabel.text = label
    }

}
