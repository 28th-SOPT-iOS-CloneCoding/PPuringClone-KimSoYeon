//
//  NowBookingVC.swift
//  CGVMovieApp
//
//  Created by soyeon on 2021/05/15.
//

import UIKit
import SnapKit

class NowBookingVC: UIViewController {
    
    @IBOutlet weak var swipeButton: UIView!
    @IBOutlet weak var selectTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        swipeDownToDismiss()
        setTableView()
    }
    
    func setTableView() {
        selectTableView.delegate = self
        selectTableView.dataSource = self
    }
    
    @IBAction func touchUpCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UI
extension NowBookingVC {
    func setUI() {
        swipeButton.layer.cornerRadius = 3
    }
}

// MARK: - Action
extension NowBookingVC {
    func swipeDownToDismiss() {
        let swipeAction = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown))
        swipeAction.direction = .down
        self.view.addGestureRecognizer(swipeAction)
    }
    @objc func swipeDown() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension NowBookingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "극장선택"
        }
        else if section == 1 {
            return "날짜/시간"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .white
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .black
        header.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 180
        }
        return 200
    }
    
}

extension NowBookingVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TheaterTVC.identifier) as? TheaterTVC else {
                return UITableViewCell()
            }
            return cell
        }
        else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DateTVC.identifier) as? DateTVC else {
                return UITableViewCell()
            }
            return cell
        }
        return UITableViewCell()
    }
    
}


