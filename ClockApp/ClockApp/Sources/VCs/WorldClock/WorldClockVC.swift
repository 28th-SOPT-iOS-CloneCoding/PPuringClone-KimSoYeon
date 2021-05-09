//
//  WorldWatchVC.swift
//  ClockApp
//
//  Created by soyeon on 2021/04/29.
//

import UIKit
import SnapKit

class WorldClockVC: UIViewController {

    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var worldClockTableView: UITableView!
    
    
    private var time: [WorldTime] = []
    
    private var headerView = UIView()
    private var headerLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        worldClockTableView.delegate = self
        worldClockTableView.dataSource = self
        
        setTimeData()
        setUpHeader()
    }
    
    private func setTimeData() {
        var timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm"
        timeFormatter.locale = Locale(identifier: "ko_KR")
        
        var currentTime = timeFormatter.string(from: Date())
        
        time.append(contentsOf: [
            WorldTime(startWord: "ㅅ", country: "서울", timeDifference: "+0", dayAndNight: "오후", time: currentTime)
        ])
    }
    
    private func setUpHeader() {
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 55))
        headerLabel = UILabel(frame: headerView.bounds)
        headerView.addSubview(headerLabel)
        headerLabel.text = "세계 시계"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 30)
        headerLabel.textColor = .white
        headerLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(25)
        }
        worldClockTableView.tableHeaderView = headerView
    }
    
    @IBAction func touchUpEdit(_ sender: Any) {
        if editButton.titleLabel?.text == "편집" {
            editButton.setTitle("완료", for: .normal)
            worldClockTableView.setEditing(true, animated: true)
            
        }
        if editButton.titleLabel?.text == "완료" {
            editButton.setTitle("편집", for: .normal)
            worldClockTableView.setEditing(false, animated: true)
        }
    }
    
    @IBAction func touchUpAdd(_ sender: Any) {
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "AddWorldClockVC") as? AddWorldClockVC else {
            return
        }
        dvc.sendCountryData = { country in
            self.time.append(country)
            self.worldClockTableView.reloadData()
        }
        dvc.modalPresentationStyle = .automatic
//        self.navigationController?.pushViewController(dvc, animated: true)
        present(dvc, animated: true, completion: nil)
    }
    
}

extension WorldClockVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return time.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorldClockCell.identifier) as? WorldClockCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.setUpClock(world: time[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(78)
    }
}

extension WorldClockVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            if !(time.isEmpty) {
                time.remove(at: indexPath.row)
                worldClockTableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let rowToMove = time[fromIndexPath.row]
        time.remove(at: fromIndexPath.row)
        time.insert(rowToMove, at: toIndexPath.row)
    }
}
