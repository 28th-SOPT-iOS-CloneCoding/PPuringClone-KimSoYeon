//
//  AlarmSoundCell.swift
//  ClockApp
//
//  Created by soyeon on 2021/05/03.
//

import UIKit

class AlarmSoundCell: UITableViewCell {
    static let identifier = "AlarmSoundCell"

    @IBOutlet weak var soundLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setLabel(song: [String]) {
        var str = " "
        if song.isEmpty {
            soundLabel.text = "없음"
        } else {
            for t in song {
                str = str + "\(t) "
            }
            soundLabel.text = str
        }
    }
}
