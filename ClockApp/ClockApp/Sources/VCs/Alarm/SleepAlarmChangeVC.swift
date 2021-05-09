//
//  SleepAlarmChangeVC.swift
//  ClockApp
//
//  Created by soyeon on 2021/05/06.
//

import UIKit

class SleepAlarmChangeVC: UIViewController {
    
    @IBOutlet weak var optionTableView: UITableView!
    @IBOutlet weak var sleepTableView: UITableView!
    
    @IBOutlet weak var changeUIView: UIView!
    
    var setSleepAlarm: (() -> Void)?
    private var sampleSoundHaptic: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeUIView.layer.cornerRadius = 15
        
        setOptionTableView()
        setSleepTableView()
    }
    
    func setOptionTableView() {
        optionTableView.delegate = self
        optionTableView.dataSource = self
        optionTableView.separatorColor = .darkGray
        optionTableView.layer.cornerRadius = 15
    }
    
    func setSleepTableView() {
        sleepTableView.delegate = self
        sleepTableView.dataSource = self
        sleepTableView.separatorColor = .darkGray
        sleepTableView.layer.cornerRadius = 15
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
//        self.navigationController?.navigationBar.backgroundColor = .darkGray
//        self.navigationController?.navigationItem.backBarButtonItem?.title = "취소"
    }
    
    @IBAction func touchUpCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpDone(_ sender: Any) {
        setSleepAlarm?()
        dismiss(animated: true, completion: nil)
    }
}

extension SleepAlarmChangeVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == optionTableView {
            if indexPath.section == 1 {
                guard let dvc = self.storyboard?.instantiateViewController(identifier:
                "OptionSoundHapticVC") as? OptionSoundHapticVC else {
                    return
                }
                sampleSoundHaptic.removeAll()
                dvc.saveSoundHaptic = { song in
                    self.sampleSoundHaptic.append(contentsOf: song)
                    self.optionTableView.reloadData()
                }
                dvc.title = "사운드 및 햅틱"
                self.navigationController?.pushViewController(dvc, animated: true)
            }
        }
        
        if tableView == sleepTableView {
            
        }
    }
}

extension SleepAlarmChangeVC : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case optionTableView:
            return 4
        case sleepTableView:
            return 2
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case optionTableView:
            return 1
        case sleepTableView:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == sleepTableView {
            if indexPath.section == 0 {
                return 100
            }
            return 50
        }
        return 43.5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == optionTableView {
            if indexPath.section == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: WakeUpAlarmCell.identifier) as? WakeUpAlarmCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                return cell
            }
            if indexPath.section == 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SoundHapticCell.identifier) as? SoundHapticCell else {
                    return UITableViewCell()
                }
                cell.setLabel(song: sampleSoundHaptic)
                cell.selectionStyle = .none
                return cell
            }
            if indexPath.section == 2 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SoundControlCell.identifier) as? SoundControlCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                return cell
            }
            if indexPath.section == 3 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmAgainCell.identifier) as? AlarmAgainCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                return cell
            }
        }
        else if tableView == sleepTableView {
            if indexPath.section == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SleepTimeLabelCell.identifier) as? SleepTimeLabelCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                return cell
            }
            if indexPath.section == 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SleepTimeEditCell.identifier) as? SleepTimeEditCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
}
