//
//  WorldClockTableViewCell.swift
//  ClockApp
//
//  Created by soyeon on 2021/04/29.
//

import UIKit

class WorldClockCell: UITableViewCell {
    static let identifier = "WorldClockCell"
    
    @IBOutlet weak var timeDifferLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var dayAndNightLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpClock(world: WorldTime) {
        countryLabel.text = world.country
        dayAndNightLabel.text = world.dayAndNight
        timeLabel.text = world.time
        timeDifferLabel.text = "오늘, \(world.timeDifference)시간"
    }

}
