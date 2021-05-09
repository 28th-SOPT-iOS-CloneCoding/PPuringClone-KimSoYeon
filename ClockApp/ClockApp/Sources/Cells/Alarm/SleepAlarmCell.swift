//
//  SleepAlarmCell.swift
//  ClockApp
//
//  Created by soyeon on 2021/05/02.
//

import UIKit

class SleepAlarmCell: UITableViewCell {
    
    @IBOutlet weak var alarmLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var subLabel: UILabel!
    
    var actionButton: (() -> Void)? = nil
    
    var mode: Int?
    
    static let identifier = "SleepAlarmCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        editButton.layer.masksToBounds = true
        editButton.layer.cornerRadius = 10
    }

    func setUpAlarm() {
        alarmLabel.text = "알람 있음"
        alarmLabel.textColor = .white
        
        subLabel.text = "오늘 아침"
        subLabel.textColor = .white
    }
    
    func setMode() {
        mode = 1
    }
    
    func setUpChangedAlarm() {
        alarmLabel.text = "오전 7:00"
        alarmLabel.textColor = .white
        
        subLabel.text = "내일 아침만"
        subLabel.textColor = .white
    }
    
    @IBAction func touchUpEdit(_ sender: Any) {
        actionButton?()
    }
}
