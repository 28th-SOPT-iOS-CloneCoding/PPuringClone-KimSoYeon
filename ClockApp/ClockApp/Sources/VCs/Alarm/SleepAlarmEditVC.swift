//
//  SleepAlarmEditVC.swift
//  ClockApp
//
//  Created by soyeon on 2021/05/02.
//

import UIKit

class SleepAlarmEditVC: UIViewController {
    
    @IBOutlet weak var appSettingButton: UIButton!
    
    var setSleepAlarm: (() -> Void)?
    var setMode: ((Int) -> Void)?
    
    var mode: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        appSettingButton.layer.masksToBounds = true
        appSettingButton.layer.cornerRadius = 15
    }
    
    @IBAction func touchUpCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpSetting(_ sender: Any) {
        setSleepAlarm?()
        setMode?(mode)
//        NotificationCenter.default.post(name: NSNotification.Name("Mode"), object: mode)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpNotSetting(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
