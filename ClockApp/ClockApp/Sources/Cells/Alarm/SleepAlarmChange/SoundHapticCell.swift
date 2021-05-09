//
//  SoundHapticCell.swift
//  ClockApp
//
//  Created by soyeon on 2021/05/06.
//

import UIKit

class SoundHapticCell: UITableViewCell {
    static let identifier = "SoundHapticCell"

    @IBOutlet weak var songLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setLabel(song: [String]) {
        var str = " "
        if song.isEmpty {
            songLabel.text = "이른 기상"
        } else {
            for t in song {
                str = str + "\(t)>"
            }
            songLabel.text = str
        }
    }

}
