//
//  AddStoryVC.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/05/24.
//


import UIKit

class AddStoryVC: UIViewController {
    private let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = UIColor.lightGray
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 100, weight: .light), forImageIn: .normal)
        button.addTarget(self, action: #selector(touchUpPlus(_:)), for: .touchUpInside)
        return button
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.NotoSerif(.light, size: 17)
        label.textColor = UIColor.lightGray
        label.text = "+를 눌러서 새 이야기를 시작하세요"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
}

// MARK: -  UI

extension AddStoryVC {
    func setUI() {
        view.addSubviews([plusButton, descriptionLabel])

        plusButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-30)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(plusButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - Action

extension AddStoryVC {
    @objc func touchUpPlus(_ sender: UIButton) {
        let storyTitleVC = StoryTitleVC()
        let navigationController = UINavigationController(rootViewController: storyTitleVC)

        navigationController.modalPresentationStyle = .overCurrentContext

        present(navigationController, animated: true, completion: nil)
    }
}
