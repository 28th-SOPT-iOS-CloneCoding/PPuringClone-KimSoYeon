//
//  NowBookingVC.swift
//  CGVMovieApp
//
//  Created by soyeon on 2021/05/15.
//

import UIKit
import SnapKit

class NowBookingVC: UIViewController {
    private var viewTranslation = CGPoint(x: 0, y: 0)
    
    @IBOutlet weak var swipeButton: UIView!
    @IBOutlet weak var selectTableView: UITableView!
    @IBOutlet weak var contentView: UIView!
    
    private lazy var timeDateHeaderView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        swipeDownToDismiss()
        setTableView()
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
    }
    
    func setTableView() {
        selectTableView.delegate = self
        selectTableView.dataSource = self
    }
    
    @IBAction func touchUpCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func handleDismiss(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            viewTranslation = sender.translation(in: view)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                if self.viewTranslation.y >= 0 {
                    var colorAlpha = 0.3 - (self.viewTranslation.y / 1000)
                    
                    if colorAlpha < 0.1 {
                        colorAlpha = 0.1
                    }
                    self.view.backgroundColor = UIColor.black.withAlphaComponent(colorAlpha
                    )
                    
                    self.swipeButton.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
                    self.contentView.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
                }
            })
        case .ended:
            if viewTranslation.y < 200 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
                    self.swipeButton.transform = .identity
                    self.contentView.transform = .identity
                })
            } else {
                self.view.backgroundColor = UIColor.clear
                dismiss(animated: true, completion: nil)
            }
        default:
            break
        }
    }
}

// MARK: - UI
extension NowBookingVC {
    func setUI() {
        self.view.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        contentView.layer.cornerRadius = 15
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

// MARK: - TableView Delegate
extension NowBookingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "극장선택"
        }
        return "날짜/시간"
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
            return 155
        }
        return 225
    }
    
}

// MARK: - TableView DataSource
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DateTimeTVC.identifier) as? DateTimeTVC else {
                return UITableViewCell()
            }
            return cell
        }
        return UITableViewCell()
    }
    
}


