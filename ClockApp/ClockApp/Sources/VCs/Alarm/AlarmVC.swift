//
//  AlarmVC.swift
//  ClockApp
//
//  Created by soyeon on 2021/05/02.
//

import UIKit
import SnapKit

class AlarmVC: UIViewController {
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var alarmTableView: UITableView!
    
    private var headerView = UIView()
    private var headerLabel = UILabel()
    
    private var alarm: [Alarm] = []
    var currentMode: Int = 0
    var modeChange: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpHeader()
        setAlarmData()
        
        alarmTableView.delegate = self
        alarmTableView.dataSource = self
        alarmTableView.separatorColor = .darkGray
        alarmTableView.removeExtraCellLines()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(modeChange)
    }
    
    private func setUpHeader() {
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 55))
        headerLabel = UILabel(frame: headerView.bounds)
        headerView.addSubview(headerLabel)
        headerLabel.text = "알람"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 30)
        headerLabel.textColor = .white
        headerLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(25)
        }
        alarmTableView.tableHeaderView = headerView
    }
    
    private func setAlarmData() {
        alarm.append(contentsOf: [
            Alarm(dayAndNight: "오전", alarmTime: "7:00", alarmOn: false),
            Alarm(dayAndNight: "오전", alarmTime: "7:30", alarmOn: false),
            Alarm(dayAndNight: "오전", alarmTime: "8:00", alarmOn: true),
            Alarm(dayAndNight: "오전", alarmTime: "8:30", alarmOn: false)
        ])
    }
    
    @IBAction func touchUpEdit(_ sender: Any) {
        if editButton.titleLabel?.text == "편집" {
            editButton.setTitle("완료", for: .normal)
            alarmTableView.setEditing(true, animated: true)
        }
        if editButton.titleLabel?.text == "완료" {
            editButton.setTitle("편집", for: .normal)
            alarmTableView.setEditing(false, animated: true)
        }
    }
    
    @IBAction func touchUpAdd(_ sender: Any) {
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "AddAlarmVC") as? AddAlarmVC else {
            return
        }
        let vc = UINavigationController(rootViewController: dvc)
        dvc.saveData = { time in
            var timeArray = time.components(separatedBy: " ")
            var dayNnight: String = " "
            
            if timeArray[0] == "AM" {
                dayNnight = "오전"
            } else if timeArray[0] == "PM" {
                dayNnight = "오후"
            }
            
            var alarmArray = timeArray[1].components(separatedBy: ":")
            alarmArray[0] = "\(atoi(alarmArray[0]) % 12)"
            timeArray[1] = "\(alarmArray[0]):\(alarmArray[1])"
            
            self.alarm.append(Alarm(dayAndNight: "\(dayNnight)", alarmTime:"\(timeArray[1])", alarmOn: true))
            self.alarmTableView.reloadData()
        }
//        NotificationCenter.default.addObserver(self, selector:#selector(dataReceived) ,name: Notification.Name("Mode"), object: nil)
        vc.modalPresentationStyle = .pageSheet
        present(vc, animated: true, completion: nil)
    }
    
//    @objc func dataReceived(notification: Notification) {
//        if let mode = notification.object as? Int {
//            currentMode = mode
//        }
//    }
    
}


extension AlarmVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "수면 | 기상"
        }
        return "기타"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 56
        }
        return 66
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return alarm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SleepAlarmCell.identifier) as? SleepAlarmCell else {
                return UITableViewCell()
            }
            
            if modeChange == 0 {
                cell.actionButton = {
                    guard let dvc = self.storyboard?.instantiateViewController(identifier: "SleepAlarmEditVC") as? SleepAlarmEditVC else {
                        return
                    }
                    dvc.setSleepAlarm = {
                        cell.setUpAlarm()
                    }
                    dvc.modalPresentationStyle = .pageSheet
                    self.present(dvc, animated: true, completion: nil)
                }
                return cell
            }
            cell.actionButton = {
                guard let dvc = self.storyboard?.instantiateViewController(identifier: "SleepAlarmChangeVC") as? SleepAlarmChangeVC else {
                    return
                }
                let vc = UINavigationController(rootViewController: dvc)
                dvc.setSleepAlarm = {
                    cell.setUpChangedAlarm()
                }
                vc.modalPresentationStyle = .pageSheet
                self.present(vc, animated: true, completion: nil)
            }
            return cell
            
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmCell.identifier) as? AlarmCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.setAlarm(alarm: alarm[indexPath.row])
        return cell
    }
    
}

extension AlarmVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            if (editingStyle == .delete) {
                if !(alarm.isEmpty) {
                    alarm.remove(at: indexPath.row)
                    alarmTableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
    }
}




