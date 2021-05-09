//
//  TimerVC.swift
//  ClockApp
//
//  Created by soyeon on 2021/04/17.
//

import UIKit
import UserNotifications

class TimerVC: UIViewController {

    @IBOutlet weak var circularProgressView: CircularProgressView!
    @IBOutlet weak var timePickerView: UIPickerView!
    
    @IBOutlet weak var musicLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    
    var isStart: Bool = false
    var timer: Timer?
    let timeSelector: Selector = #selector(TimerVC.updateTime)
    var currentTimeCount = 0
    var totalTime = 0
    var alarmTime: String?
    
    var hour:Int = 0
    var minutes:Int = 0
    var seconds:Int = 0

    var musicName: String?
    
    var cpView: CircularProgressView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timePickerView.delegate = self
        
        initialSetUp()
    }
    
    func initialSetUp() {
        timePickerView.setValue(UIColor.white, forKeyPath: "textColor")
        timerLabel.isHidden = true
        
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.layer.masksToBounds = true
        cancelButton.layer.cornerRadius = 35
        cancelButton.isEnabled = false
        
        startButton.setTitle("시작", for: .normal)
        startButton.setTitleColor(UIColor.init(red: 142/255, green: 250/255, blue: 0, alpha: 1), for: .normal)
        startButton.backgroundColor = UIColor.init(red: 55/255, green: 55/255, blue: 55/255, alpha: 1)
        startButton.layer.masksToBounds = true
        startButton.layer.cornerRadius = 35
        startButton.isEnabled = false
        
        musicButton.layer.masksToBounds = true
        musicButton.layer.cornerRadius = 8
        
        circularProgressSetUp()
    }
    
    func circularProgressSetUp() {
        circularProgressView.isHidden = true
        circularProgressView.trackColor = UIColor.darkGray
        circularProgressView.progressColor = UIColor.orange
        circularProgressView.tag = 101
    }
    
    @objc func animateProgress() {
        cpView = self.view.viewWithTag(101) as? CircularProgressView
        cpView?.setCurrentProgress(duration: TimeInterval(Float(totalTime)), value: Float(currentTimeCount/totalTime))
    }
    
    func timeSetUp() {
        timerLabel.text = alarmTime ?? " "
        
        let alarmArray = alarmTime?.components(separatedBy: ":")
        var times: [Int] = []
        
        guard let hourTime = alarmArray?[0], let minTime = alarmArray?[1], let secTime = alarmArray?[2] else {
            return
        }
        
        times.append(Int(hourTime) ?? 0)
        times.append(Int(minTime) ?? 0)
        times.append(Int(secTime) ?? 0)
        
        totalTime = times[2] + 60 * times[1] + 3600 * times[0]
        currentTimeCount = times[2] + 60 * times[1] + 3600 * times[0]
    }
    
    func timeFormatter(_ intTime: Int) -> String {
        let hour = intTime / 3600
        let min = (intTime % 3600) / 60
        let sec = (intTime % 3600) % 60
        
        let hourStr =  hour < 10 ? "0\(hour)" :String(hour)
        let minStr = min < 10 ? "0\(min)" : String(min)
        let secStr = sec < 10 ? "0\(sec)" : String(sec)
        
        return "\(hourStr):\(minStr):\(secStr)"
    }
    
    @objc func updateTime() {
        currentTimeCount -= 1
        timerLabel.text = timeFormatter(currentTimeCount)
        circularProgressView.reloadInputViews()
        
        if currentTimeCount == 0 {
            isStart = false
            timerLabel.isHidden = true
            timePickerView.isHidden = false
            circularProgressView.isHidden = true
            
            currentTimeCount = 0
            timer?.invalidate()
            
            startButton.setTitle("시작", for: .normal)
            startButton.setTitleColor(UIColor.init(red: 142/255, green: 250/255, blue: 0, alpha: 1), for: .normal)
            startButton.backgroundColor = UIColor.init(red: 50/255, green: 76/255, blue: 21/255, alpha: 1)
        }
    }
    
    @IBAction func touchUpStart(_ sender: Any) {
        if isStart == false {
            timeSetUp()
            isStart = true
            timerLabel.isHidden = false
            timePickerView.isHidden = true
            circularProgressView.isHidden = false
            
            cancelButton.isEnabled = true
            
            startButton.setTitle("일시 정지", for: .normal)
            startButton.backgroundColor = UIColor.init(red: 244/255, green: 134/255, blue: 60/255, alpha: 1)
            startButton.setTitleColor(UIColor.white, for: .normal)
            
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: timeSelector, userInfo: nil, repeats: true)
            
            self.perform(#selector(animateProgress), with: nil, afterDelay: 0.0)
            
        } else if isStart && timer!.isValid {
            startButton.setTitle("재개", for: .normal)
            startButton.setTitleColor(UIColor.init(red: 142/255, green: 250/255, blue: 0, alpha: 1), for: .normal)
            startButton.backgroundColor = UIColor.init(red: 50/255, green: 76/255, blue: 21/255, alpha: 1)
            timer?.invalidate()
            // ?
        } else if isStart && !(timer!.isValid) {
            startButton.setTitle("일시 정지", for: .normal)
            startButton.setTitleColor(UIColor.white, for: .normal)
            startButton.backgroundColor = UIColor.init(red: 244/255, green: 134/255, blue: 60/255, alpha: 1)
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: timeSelector, userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func touchUpCancel(_ sender: Any) {
        timePickerView.isHidden = false
        timerLabel.isHidden = true
        circularProgressView.isHidden = true
        
        timer?.invalidate()
        isStart = false
        cancelButton.isEnabled = false
        currentTimeCount = 0
        
        timerLabel.text = timeFormatter(0)
        
        startButton.setTitle("시작", for: .normal)
        startButton.setTitleColor(UIColor.init(red: 142/255, green: 250/255, blue: 0, alpha: 1), for: .normal)
        startButton.backgroundColor = UIColor.init(red: 50/255, green: 76/255, blue: 21/255, alpha: 1)
    }
    
    @IBAction func touchUpMusic(_ sender: Any) {
        guard let musicVC = self.storyboard?.instantiateViewController(identifier: "TimerMusicVC") as? TimerMusicVC else {
            return
        }
        musicVC.delegate = self
        musicVC.modalPresentationStyle = .pageSheet
        present(musicVC, animated: true, completion: nil)
    }
    
}

extension TimerVC: sendBackDelegate{
    func dataReceived(data: String) {
        musicLabel.text = data
    }
}

extension TimerVC: UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 25
        case 1,2:
            return 60

        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.width/3
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row) 시간"
        case 1:
            return "\(row) 분"
        case 2:
            return "\(row) 초"
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            hour = row
        case 1:
            minutes = row
        case 2:
            seconds = row
        default:
            break;
        }
        alarmTime = "0\(hour):0\(minutes):0\(seconds)"
        startButton.isEnabled = true
        startButton.backgroundColor = UIColor.init(red: 50/255, green: 76/255, blue: 21/255, alpha: 1)
    }
}
