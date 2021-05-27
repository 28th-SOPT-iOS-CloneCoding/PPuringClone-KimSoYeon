//
//  MainVC.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/05/27.
//

import UIKit
import SnapKit
import RealmSwift

class MainVC: UIViewController {
    var customBar: UINavigationBar = UINavigationBar()
    private lazy var headerView: UIView = {
        let view = UIView()
        view.addSubview(storyTitle)
        view.addSubview(storySubTitle)
        
//        view.snp.makeConstraints { make in
//            make.width.equalTo(view)
//            make.height.equalTo(100)
//        }
        
        storyTitle.snp.makeConstraints { make in
            make.top.equalTo(view).inset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        storySubTitle.snp.makeConstraints { make in
            make.top.equalTo(storyTitle.snp.bottom).offset(15)
            make.centerX.equalTo(storyTitle)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        return view
    }()
    private lazy var storyTitle: UILabel = {
        let label = UILabel()
        label.text = "첫번째 이야기"
        label.font = .NotoSerif(.semiBold, size: 20)
        return label
    }()
    private lazy var storySubTitle: UILabel = {
        let label = UILabel()
        label.text = "새로운 이야기 소제목"
        label.font = .NotoSerif(.light, size: 15)
        return label
    }()
    
    private lazy var storyListTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExtraCellLines()
        
        let selectNib = UINib(nibName: "StoryListTVC", bundle: nil)
        tableView.register(selectNib, forCellReuseIdentifier: StoryListTVC.identifier)
        
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationItem.titleView = headerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }

}

extension MainVC {
    private func setUI() {
        view.addSubview(storyListTableView)
        
        storyListTableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        100
    }

    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryListTVC") as? StoryListTVC else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        return cell
    }
  
}
