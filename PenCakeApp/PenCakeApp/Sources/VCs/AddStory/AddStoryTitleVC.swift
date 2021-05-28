//
//  AddStoryTitleVC.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/05/28.
//

import UIKit

class AddStoryTitleVC: UIViewController {
    private lazy var closeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(touchUpCloseButton(_:)))
        button.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.NotoSerif(.light, size: 17), NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        
        return button
    }()
    private lazy var nextButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(touchUpNextButton(_:)))
        button.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.NotoSerif(.light, size: 17)], for: .normal)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setNavigation()
    }
}

// MARK: - UI
extension AddStoryTitleVC {
    func setUI() {
        view.backgroundColor = .white
    }

    func setNavigation() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()

        self.navigationItem.leftBarButtonItem = self.closeButton
        self.navigationItem.rightBarButtonItem = self.nextButton
    }
}

// MARK: - Action
extension AddStoryTitleVC {
    @objc func touchUpCloseButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @objc func touchUpNextButton(_ sender: UIBarButtonItem) {
        navigationController?.pushViewController(AddStorySubTitleVC(), animated: true)
    }
}
