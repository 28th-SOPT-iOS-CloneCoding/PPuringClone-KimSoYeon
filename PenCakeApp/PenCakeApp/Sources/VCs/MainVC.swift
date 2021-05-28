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
    private lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addSubview(titleButton)
        view.addSubview(subTitleButton)
        
        titleButton.snp.makeConstraints { make in
            make.top.equalTo(view).inset(15)
            make.centerX.equalTo(view)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        subTitleButton.snp.makeConstraints { make in
            make.top.equalTo(titleButton.snp.bottom).offset(20)
            make.centerX.equalTo(subTitleButton)
            make.width.equalTo(400)
            make.height.equalTo(30)
        }
        return view
    }()
    
    private let titleButton: UIButton = {
        let button = UIButton()
        button.setTitle("이야기 1", for: .normal)
        button.titleLabel?.font = UIFont.NotoSerif(.semiBold, size: 20)
        button.setTitleColor(.black, for: .normal)
        button.sizeToFit()
        
        return button
    }()
    
    private let subTitleButton: UIButton = {
        let button = UIButton()
        button.setTitle("여기를 눌러서 제목을 변경하세요", for: .normal)
        button.titleLabel?.font = UIFont.NotoSerif(.light, size: 14)
        button.setTitleColor(.black, for: .normal)
        button.sizeToFit()
        
        return button
    }()
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        
        return table
    }()
    
    private lazy var newWritingControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(addNewWriting(_:)), for: .valueChanged)
        control.tintColor = .clear
        
        return control
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setTableView()
    }
    
}

// MARK: - UI
extension MainVC {
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let storylistNib = UINib(nibName: "StoryListTVC", bundle: nil)
        tableView.register(storylistNib, forCellReuseIdentifier: StoryListTVC.identifier)
        tableView.refreshControl = newWritingControl
        
        tableView.separatorStyle = .none
    }
}

// MARK: - Action
extension MainVC {
    @objc func addNewWriting(_ sender: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            sender.endRefreshing()
        }
    
        let writingVC = UINavigationController(rootViewController: WritingVC())
        writingVC.modalPresentationStyle = .overFullScreen
        present(writingVC, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate
extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

// MARK: - UITableViewDataSource
extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryListTVC") as? StoryListTVC else {
            return UITableViewCell()
        }
        return cell
    }
}
