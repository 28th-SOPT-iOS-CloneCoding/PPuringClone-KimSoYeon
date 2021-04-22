//
//  StopWatchVC.swift
//  ClockApp
//
//  Created by soyeon on 2021/04/13.
//

import UIKit

class StopWatchVC: UIViewController {
    
    @IBOutlet weak var stopwatchLabel: UILabel!
    @IBOutlet weak var decimalLabel: UILabel!
    @IBOutlet weak var lapBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var recordTableView: UITableView!
    
    var isStart: Bool = false
    var isLap: Bool = false
    
    var timer: Timer?
    let timeSelector: Selector = #selector(StopWatchVC.updateTime)
    
    var currentTimeCount: Int = 0
    var lapTimerString: String?
    
    var laps: [String] = []
    var lapsDiff: [String] = []
    
    // lap의 차이를 저장하는 lapStopWatch / 차이 값을 저장할 lapString 변수
    var lapStopWatch: StopWatch = StopWatch()
    @IBOutlet weak var lapTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordTableView.delegate = self
        recordTableView.dataSource = self
        setUpButtons()
    }
    
    func setUpButtons() {
        stopwatchLabel.text = timeFormatter(0)
        decimalLabel.text = timeFormatterSec(0)
        
        lapBtn.setTitle("랩", for: .normal)
        lapBtn.layer.masksToBounds = true
        lapBtn.layer.cornerRadius = 35
        lapBtn.isEnabled = false
        
        startBtn.setTitle("시작", for: .normal)
        startBtn.setTitleColor(UIColor.init(red: 142/255, green: 250/255, blue: 0, alpha: 1), for: .normal)
        startBtn.backgroundColor = UIColor.init(red: 50/255, green: 76/255, blue: 21/255, alpha: 1)
        startBtn.layer.masksToBounds = true
        startBtn.layer.cornerRadius = 35
    }
    
//    func timeFormatter(_ intTime: Int) -> String {
//        let hour = intTime / 3600
//        let min = (intTime % 3600) / 60
//        let sec = (intTime % 3600) % 60
//
//        let hourStr =  hour < 10 ? "0\(hour)" :String(hour)
//        let minStr = min < 10 ? "0\(min)" : String(min)
//        let secStr = sec < 10 ? "0\(sec)" : String(sec)
//
//        return "\(hourStr):\(minStr):\(secStr)"
//    }
    
    func timeFormatter(_ intTime: Int) -> String {
        let hour = intTime / 3600
        let min = (intTime % 3600) / 60

        let hourStr =  hour < 10 ? "0\(hour)" :String(hour)
        let minStr = min < 10 ? "0\(min)" : String(min)

        return "\(hourStr):\(minStr)."
    }
    
    func timeFormatterSec(_ intTime: Int) -> String {
        let sec = (intTime % 3600) % 60

        let secStr = sec < 10 ? "0\(sec)" : String(sec)

        return "\(secStr)"
    }
    
    @objc func updateTime(){
        currentTimeCount += 1
        
//        stopwatchLabel.text = timeFormatter(currentTimeCount)
//        lapTimerString = timeFormatter(currentTimeCount)
        
        stopwatchLabel.text = timeFormatter(currentTimeCount)
        decimalLabel.text = timeFormatterSec(currentTimeCount)

        lapTimerString = timeFormatter(currentTimeCount) + timeFormatterSec(currentTimeCount)
    }
    
    @objc func updateLapTimer(_ stopwatch: StopWatch, label: UILabel) {
        stopwatch.counter = stopwatch.counter + 0.035

        var minutes: String = String(Int(stopwatch.counter / 60))
        if Int(stopwatch.counter / 60) < 10 {
            minutes = "0" + minutes
        }

        var seconds: String = String(format: "%.2f", (stopwatch.counter.truncatingRemainder(dividingBy: 60)))
        if stopwatch.counter.truncatingRemainder(dividingBy: 60) < 10 {
            seconds = "0" + seconds
        }

        label.text = minutes + ":" + seconds
    }
    
    @IBAction func touchUpStart(_ sender: Any) {
        // MARK: - 최초 시작, 일시 정지, 재개
        if isStart == false {
            isLap = true
            isStart = true
            lapBtn.isEnabled = true
            
            startBtn.setTitle("중단", for: .normal)
            startBtn.setTitleColor(UIColor.init(red: 255/255, green: 38/255, blue: 0, alpha: 1), for: .normal)
            startBtn.backgroundColor = UIColor.init(red: 148/255, green: 17/255, blue: 0, alpha: 1)
            
            stopwatchLabel.text = timeFormatter(currentTimeCount)
            decimalLabel.text = timeFormatterSec(currentTimeCount)
            timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: timeSelector, userInfo: nil, repeats: true)
            
//            lapStopWatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
//            RunLoop.current.add(lapStopWatch.timer, forMode: RunLoop.Mode.common)
            
        } else if isStart && timer!.isValid {
            isLap = false
            
            startBtn.setTitle("시작", for: .normal)
            startBtn.setTitleColor(UIColor.init(red: 142/255, green: 250/255, blue: 0, alpha: 1), for: .normal)
            startBtn.backgroundColor = UIColor.init(red: 50/255, green: 76/255, blue: 21/255, alpha: 1)
            lapBtn.setTitle("재설정", for: .normal)
            
            timer?.invalidate()
            lapStopWatch.timer.invalidate()
            
        } else if isStart && !(timer!.isValid) {
            isLap = true
            startBtn.setTitle("중단", for: .normal)
            startBtn.setTitleColor(UIColor.init(red: 255/255, green: 38/255, blue: 0, alpha: 1), for: .normal)
            startBtn.backgroundColor = UIColor.init(red: 148/255, green: 17/255, blue: 0, alpha: 1)
            lapBtn.setTitle("랩", for: .normal)
            
            timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: timeSelector, userInfo: nil, repeats: true)
            
//            lapStopWatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: #selector(updateLapTimer), userInfo: nil, repeats: true)
//            RunLoop.current.add(lapStopWatch.timer, forMode: RunLoop.Mode.common)
        }
    }
    
    @IBAction func touchUpLap(_ sender: Any) {
        if isLap {
            laps.append(lapTimerString ?? "")
            
            if let lapLabelText = lapTimeLabel.text {
                lapsDiff.append(lapLabelText)
            }
            
            lapStopWatch.counter = 0.0
            lapTimeLabel.text = "00:00:00"
            
            recordTableView.reloadData()
        } else {
            timer?.invalidate()
            isStart = false
            currentTimeCount = 0
            
            lapStopWatch.timer.invalidate()
            lapStopWatch.counter = 0.0
            lapTimeLabel.text = "00:00:00"
            
            laps.removeAll()
            recordTableView.reloadData()
            
            lapBtn.setTitle("랩", for: .normal)
            lapBtn.isEnabled = false
            
            stopwatchLabel.text = timeFormatter(0)
            decimalLabel.text = timeFormatterSec(0)
        }
    }
    
}

extension StopWatchVC: UITableViewDelegate {
    
}

extension StopWatchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordCell.identifier) as? RecordCell else {
            return UITableViewCell()
        }
        laps.sort(by: { $0 > $1 })
        
        let recordCellItem = self.laps[indexPath.row]
        cell.lapCountLabel.text = "랩 \(laps.count - indexPath.row)"
        cell.lapRecordLabel.text = recordCellItem
        return cell
    }
}
