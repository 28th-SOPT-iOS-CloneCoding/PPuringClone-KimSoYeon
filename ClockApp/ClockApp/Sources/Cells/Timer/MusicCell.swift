//
//  MusicCell.swift
//  ClockApp
//
//  Created by soyeon on 2021/04/17.
//

import UIKit

class MusicCell: UITableViewCell {
    static let identifier = "MusicCell"

    @IBOutlet weak var musicLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // TODO: - check box가 왼쪽으로 가도록 .. custom cell로
        accessoryType = selected ? .checkmark : .none
        tintColor = .orange
    }

}
