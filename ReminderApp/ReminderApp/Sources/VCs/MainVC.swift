//
//  MainVC.swift
//  ReminderApp
//
//  Created by soyeon on 2021/06/21.
//

import UIKit
import SnapKit

class MainVC: UIViewController {
    
    // MARK: - UIComponents
    private lazy var editButton: UIBarButtonItem = {
        let editButton = UIBarButtonItem(title: "편집", style: .plain, target: self, action: #selector(self.pressEditButton(_:)))
        editButton.title = "편집"
        return editButton
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "검색"
        return searchController
    }()
    
    private lazy var mainTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    var isEdit = false
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationController()
        setTableView()
        setConstraint()
    }
}

// MARK: - Custom Methods
extension MainVC {
    func setNavigationController() {
        navigationItem.rightBarButtonItem = editButton
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        
        let backBarButtonItem = UIBarButtonItem(title: "목록", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    func setTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        mainTableView.register(MainListTVC.self, forCellReuseIdentifier: MainListTVC.identifier)
    }
    
    func setConstraint() {
        view.addSubview(mainTableView)
        
        mainTableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - Action Methods

extension MainVC {
    @objc
    func pressEditButton(_ sender: UIBarButtonItem) {
        if isEdit {
            editButton.title = "편집"
            isEdit = false
            mainTableView.setEditing(false, animated: true)
        } else {
            editButton.title = "완료"
            isEdit = true
            mainTableView.setEditing(true, animated: true)
        }
    }
}

extension MainVC: UITableViewDelegate {
    
}

extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainListTVC.identifier) as? MainListTVC else {
            return UITableViewCell()
        }
        return cell
    }
}
