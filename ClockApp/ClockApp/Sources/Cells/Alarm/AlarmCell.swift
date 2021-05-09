//
//  AlarmCell.swift
//  ClockApp
//
//  Created by soyeon on 2021/05/02.
//

import UIKit

class AlarmCell: UITableViewCell {
    
    static let identifier = "AlarmCell"
    
    @IBOutlet weak var dayAndNightLabel: UILabel!
    @IBOutlet weak var alarmTimeLabel: UILabel!
    @IBOutlet weak var alarmTextLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setAlarm(alarm: Alarm) {
        alarmTimeLabel.text = alarm.alarmTime
        dayAndNightLabel.text = alarm.dayAndNight
        if alarm.alarmOn {
            alarmTimeLabel.textColor = .white
            dayAndNightLabel.textColor = .white
            alarmTextLabel.textColor = .white
            alarmSwitch.isOn = true
        } else {
            alarmTimeLabel.textColor = .gray
            dayAndNightLabel.textColor = .gray
            alarmTextLabel.textColor = .gray
            alarmSwitch.isOn = false
        }
    }

    @IBAction func touchUpSwitch(_ sender: Any) {
        if alarmSwitch.isOn {
            alarmTimeLabel.textColor = .white
            dayAndNightLabel.textColor = .white
            alarmTextLabel.textColor = .white
        }
        else {
            alarmTimeLabel.textColor = .gray
            dayAndNightLabel.textColor = .gray
            alarmTextLabel.textColor = .gray
        }
    }
}
