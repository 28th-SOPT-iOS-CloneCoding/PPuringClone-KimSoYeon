//
//  RepeatCell.swift
//  ClockApp
//
//  Created by soyeon on 2021/05/03.
//

import UIKit

class RepeatCell: UITableViewCell {
    static let identifier = "RepeatCell"

    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setLabel(date: String) {
        dateLabel.text = "\(date)요일마다"
    }

}
