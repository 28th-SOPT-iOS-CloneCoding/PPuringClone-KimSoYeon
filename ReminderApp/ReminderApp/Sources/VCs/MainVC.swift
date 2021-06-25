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
        let editButton = UIBarButtonItem(title: "편집", style: .plain, target: self, action: #selector(self.touchUpEdit(_:)))
        editButton.title = "편집"
        return editButton
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "검색"
        return searchController
    }()
    
    private lazy var mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsMultipleSelection = true
        return collectionView
    }()
    
    private lazy var mainTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private lazy var newAlertButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.setTitle(" 새로운 미리 알림", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.sizeToFit()
        button.addTarget(self, action: #selector(touchUpNewAlert(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var addListButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: "목록 추가",
            style: .plain,
            target: self,
            action: #selector(touchUpAddList(_:)))
        return button
    }()
    
    private lazy var toolBar: UIToolbar = {
        let toolbar = UIToolbar()
        view.addSubview(toolbar)
        
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 0).isActive = true
        toolbar.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0).isActive = true
        toolbar.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 0).isActive = true
        
        toolbar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        toolbar.isTranslucent = true
        toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
        return toolbar
    }()
    
    // MARK: - Local Variables
    
    var isEdit = false
    let collectionViewTopAnchor: CGFloat = 0
    let tableViewTopAnchor: CGFloat = -300
    
    var items: [UIBarButtonItem] = []
    var lists: [String] = ["뿌링클론코딩", "미라클론코딩", "스펙타클론코딩", "오라클론코딩"]
    var menus: [String] = ["전체", "오늘", "예정"]
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        setNavigationController()
        setCollectionView()
        setTableView()
        setToolbarItem()
    }
    
    override func viewWillLayoutSubviews() {
        mainCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(mainCollectionView.snp.bottom).offset(20)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - Custom Methods

extension MainVC {
    func setView() {
        view.backgroundColor = .systemGray6
        
        view.addSubviews([mainCollectionView, mainTableView, toolBar])
    }
    
    func setNavigationController() {
        self.navigationItem.rightBarButtonItem = self.editButton
        
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController?.searchBar.placeholder = "검색"
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func setCollectionView() {
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
        mainCollectionView.register(MainListCVC.self, forCellWithReuseIdentifier: MainListCVC.identifier)
        
        mainCollectionView.backgroundColor = .systemGray6
    }
    
    func setTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        mainTableView.register(MainListTVC.self, forCellReuseIdentifier: MainListTVC.identifier)
        
        mainTableView.separatorStyle = .none
        mainTableView.separatorColor = .clear
        mainTableView.backgroundColor = .systemGray6
    }
    
    func setToolbarItem() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let leftButton = UIBarButtonItem(customView: newAlertButton)
        
        items.append(leftButton)
        items.append(flexibleSpace)
        items.append(addListButton)
        
        toolBar.setItems(items, animated: true)
    }
}

// MARK: - Action Methods

extension MainVC {
    @objc
    func touchUpEdit(_ sender: UIBarButtonItem) {
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
    
    @objc
    private func touchUpNewAlert(_ sender: UIButton) {
        let dvc = NewAlertVC()
        dvc.modalPresentationStyle = .popover
        self.present(dvc, animated: true, completion: nil)
    }
    
    @objc
    private func touchUpAddList(_ sender: Any) {
        let dvc = NewListVC()
        dvc.modalPresentationStyle = .popover
        self.present(dvc, animated: true, completion: nil)
    }
}

// MARK: - UICollectionView Delegate

extension MainVC: UICollectionViewDelegate {
    
}

extension MainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainListCVC.identifier, for: indexPath) as? MainListCVC else {
            return UICollectionViewCell()
        }
        return cell
    }
}

extension MainVC: UICollectionViewDelegateFlowLayout {
    
}


// MARK: - UITableView Delegate

extension MainVC: UITableViewDelegate {
    
}

// MARK: - UITableView DataSource

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
