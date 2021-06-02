//
//  AddStorySubTitleVC.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/05/28.
//

import UIKit
import RealmSwift

class AddStorySubTitleVC: UIViewController {
    private lazy var completionButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(touchUpCompletionButton(_:)))
        button.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.NotoSerif(.light, size: 13), NSAttributedString.Key.foregroundColor: UIColor.systemBlue], for: .normal)
        
        return button
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "이야기의 소제목을 입력해주세요."
        label.font = UIFont.NotoSerif(.light, size: 13)
        
        return label
    }()
    private lazy var subContentLabel: UILabel = {
        let label = UILabel()
        label.text = "다짐말을 써도 좋아요"
        label.font = UIFont.NotoSerif(.light, size: 13)
        
        return label
    }()
    
    private var titleTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(string: "예) 오늘도 수고했어!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2])
        textField.font = .NotoSerif(.light, size: 13)
        textField.removeAuto()
        return textField
    }()
    
    private var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    var storyTitle: String?
    
    private var realm: Realm?
    private var lists: Results<Story>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realm = try? Realm()
        lists = realm?.objects(Story.self)
        
        setUI()
        setNavigation()
    }
    
    func inputData(database: Story) -> Story {
        if let title = storyTitle {
            database.title = title
        }
        if let subTitle = titleTextField.text {
            database.subTitle = subTitle
        }
        
        return database
    }
    
}

// MARK: - UI
extension AddStorySubTitleVC {
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubviews([contentLabel, subContentLabel, titleTextField, bottomLine])
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
        }
        
        subContentLabel.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(subContentLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        
        bottomLine.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
            make.width.equalTo(240)
            make.height.equalTo(1)
        }
    }
    
    func setNavigation() {
        navigationController?.navigationBar.tintColor = .systemGray4
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationItem.rightBarButtonItem = self.completionButton
    }
}

// MARK: - Action
extension AddStorySubTitleVC {
    @objc func touchUpCompletionButton(_ sender: UIBarButtonItem) {
        
        if ((titleTextField.text?.isEmpty) != nil) {
            let dvc = ContainerVC()
            dvc.makeNewViewController(title: storyTitle ?? "", subTitle: titleTextField.text ?? "")
            
//            try! realm?.write {
//                realm?.add(inputData(database: Story()))
//            }
            
            dismiss(animated: true, completion: nil)
        } else {
            let alertViewController = UIAlertController(title: nil,
                                                        message: "소제목을 입력해주세요.",
                                                        preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alertViewController.addAction(okAction)
            present(alertViewController, animated: true, completion: nil)
            
        }
        
    }
    
}

