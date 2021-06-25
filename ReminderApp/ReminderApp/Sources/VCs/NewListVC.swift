//
//  NewListVC.swift
//  ReminderApp
//
//  Created by soyeon on 2021/06/25.
//

import UIKit

class NewListVC: UIViewController {
    
    // MARK: - UIComponents
    
    private lazy var header = AddHeader(root: self, with: NewAlertVC())

    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
    }

    override func viewWillLayoutSubviews() {
        header.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
    }
}

// MARK: - Custom Methods

extension NewListVC {
    func setView() {
        view.backgroundColor = .systemGray6
        view.addSubviews([header])
        
        header.titleLabel.text = "새로운 목록 추가"
    }
}
