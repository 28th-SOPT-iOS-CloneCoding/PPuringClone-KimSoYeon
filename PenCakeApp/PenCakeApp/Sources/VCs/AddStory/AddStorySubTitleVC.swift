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
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = .NotoSerif(.light, size: 13)
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.attributedPlaceholder = NSAttributedString(string: "예) 오늘도 수고했어!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        textField.textContentType = .none
        
        return textField
    }()
    
    private var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    var storyTitle: String?
    var subStoryTitle: String?
    
    private var realm: Realm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realm = try? Realm()
        
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
        
        view.addSubview(contentLabel)
        view.addSubview(subContentLabel)
        view.addSubview(titleTextField)
        view.addSubview(bottomLine)
        
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
        ContainerVC.pages.insert(UINavigationController(rootViewController: MainStoryVC()), at: 0)
        
        try! realm?.write {
            realm?.add(inputData(database: Story()))
        }
        
        self.dismiss(animated: true) {
//            self.present(ContainerVC.pages[0], animated: true, completion: nil)
        }
        
    }
    
}

