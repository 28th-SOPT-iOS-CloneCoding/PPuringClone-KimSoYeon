//
//  MainVC.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/05/27.
//

import UIKit
import SnapKit
import RealmSwift

class MainStoryVC: UIViewController {
    var headerView = StoryHeaderView()
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .white
        return table
    }()
    
    private lazy var newWritingControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(addNewWriting(_:)), for: .valueChanged)
        control.tintColor = .clear
        
        return control
    }()
    
    private var lists: Results<Writing>?
    private var realm: Realm?
    
    let dateFormatter = DateFormatter()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realm = try? Realm()
        lists = realm?.objects(Writing.self)
        
        dateFormatter.dateFormat = "MM-dd"
        
        setUI()
        setTableView()
    }
    
}

// MARK: - UI
extension MainStoryVC {
    func setNavivationUI() {
        navigationController?.isNavigationBarHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubviews([headerView, tableView])
        
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let storylistNib = UINib(nibName: "StoryListTVC", bundle: nil)
        tableView.register(storylistNib, forCellReuseIdentifier: StoryListTVC.identifier)
//        tableView.refreshControl = newWritingControl
        
        tableView.separatorStyle = .none
    }
}

// MARK: - Action
extension MainStoryVC {
    @objc func addNewWriting(_ sender: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            sender.endRefreshing()
        }
    
        let writingVC = UINavigationController(rootViewController: WritingVC())
        writingVC.modalPresentationStyle = .overFullScreen
        present(writingVC, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate
extension MainStoryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = DetailStoryVC()
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = tableView.contentOffset.y
        
        if offset > 0 {
            headerView.updateHeaderLayout(offset: offset)
            
            if offset > 46 {
                tableView.transform = CGAffineTransform(translationX: 0, y: -110)
            } else {
                tableView.transform = CGAffineTransform(translationX: 0, y: -offset*2.5)
            }
        } else if offset == 0 {
            headerView.backToOriginalHeaderLayout()
            tableView.transform = .identity
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offset = tableView.contentOffset.y
        
        if offset < -100 {
            let nextVC = DetailStoryVC()
            self.navigationItem.backButtonTitle = ""
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

// MARK: - UITableViewDataSource
extension MainStoryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryListTVC") as? StoryListTVC else {
            return UITableViewCell()
        }
        cell.titleLabel?.text =  lists![indexPath.row].title
        cell.dateLabel?.text = dateFormatter.string(from: lists![indexPath.row].date)
        cell.selectionStyle = .none
        return cell
    }
}

extension MainStoryVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
