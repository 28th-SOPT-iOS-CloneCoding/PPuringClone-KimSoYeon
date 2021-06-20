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
    
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationController()
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
}

// MARK: - Action Methods

extension MainVC {
    @objc
    func pressEditButton(_ sender: UIBarButtonItem) {
        print("편집 버튼 누름")
    }
}
