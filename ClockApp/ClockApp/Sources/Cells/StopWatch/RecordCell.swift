//
//  RecordCell.swift
//  ClockApp
//
//  Created by soyeon on 2021/04/13.
//

import UIKit

class RecordCell: UITableViewCell {
    static let identifier = "RecordCell"

    @IBOutlet weak var lapCountLabel: UILabel!
    @IBOutlet weak var lapRecordLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
