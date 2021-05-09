//
//  AlarmRepeatVC.swift
//  ClockApp
//
//  Created by soyeon on 2021/05/03.
//

import UIKit

class AlarmRepeatVC: UIViewController {
    @IBOutlet weak var repeatTableView: UITableView!
    
    var saveDateData: (([String]) -> Void)?
    
    private var date: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    private var selectDate: [Bool] = [false, false, false, false, false, false, false]
    private var saveDate: [String] = []
    
    var indexs: Int = 0
    var deleteCell: UITableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationController()
        
        repeatTableView.delegate = self
        repeatTableView.dataSource = self
        repeatTableView.separatorColor = .darkGray
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParent
        {
            saveDateData?(saveDate)
        }
    }
    
    private func setUpNavigationController() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.backItem?.title = "뒤로"
        self.navigationController?.navigationBar.tintColor = .orange
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
}

extension AlarmRepeatVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return date.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepeatCell.identifier) as? RepeatCell else {
            return UITableViewCell()
        }
        cell.setLabel(date: date[indexPath.row])
        return cell
    }
}

extension AlarmRepeatVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectDate[indexPath.row] == false {
            if let cell = tableView.cellForRow(at: indexPath) {
                selectDate[indexPath.row] = true
                cell.accessoryType = .checkmark
                cell.tintColor = .orange
                cell.selectionStyle = .none
                saveDate.append(date[indexPath.row])
                if saveDate.count == 2 {
                    saveDate.removeFirst()
                    selectDate[indexs] = false
                    deleteCell?.accessoryType = .none
                }
                deleteCell = cell
                indexs = indexPath.row
            }
        } else {
            if let cell = tableView.cellForRow(at: indexPath) {
                selectDate[indexPath.row] = false
                cell.accessoryType = .none
                cell.selectionStyle = .none
                saveDate.removeFirst()
            }
        }
    }
}
