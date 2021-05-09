//
//  SoundCell.swift
//  ClockApp
//
//  Created by soyeon on 2021/05/03.
//

import UIKit

class SoundCell: UITableViewCell {
    static let identifier = "SoundCell"
    
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var soundLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setSongLabel(song: String) {
        songLabel.text = song
    }
    
    func setSoundLabel(song: String) {
        soundLabel.text = song
    }
}
